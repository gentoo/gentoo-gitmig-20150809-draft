# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/anomy-sanitizer/anomy-sanitizer-1.67.ebuild,v 1.4 2004/07/14 16:37:17 agriffis Exp $

DESCRIPTION="Perl based e-mail filtering tool, sensitive to html tags, mime types and attachments"
HOMEPAGE="http://mailtools.anomy.net/"
SRC_URI="http://mailtools.anomy.net/dist/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-lang/perl
		>=dev-perl/MIME-Base64-2.12-r2
		>=dev-perl/Mail-Audit-2.1-r1
		virtual/mta"
DEPEND="${RDEPEND}"


DEST="/usr/share/${PN}"
SANI_WORKDIR="/var/spool/sanitizer"


src_install() {
	keepdir ${SANI_WORKDIR}
	dodir ${DEST}
	insinto ${DEST}

# generate lists for doins
	_list="anomy anomy/bin anomy/bin/Anomy anomy/bin/Anomy/Sanitizer anomy/contrib anomy/testcases anomy/testcases/results.def"

	for i in $_list; do
		_di=`echo $i | sed -e "s/^anomy//g; s/^\///g"`
		insinto ${DEST}/$_di

		_sublist=`find ${WORKDIR}/$i/* -type f -maxdepth 0`
		for l in $_sublist; do
			echo
			doins $l
		done
	done

	insinto ${DEST}
	doins ${FILESDIR}/*.conf
	doins ${FILESDIR}/*.sh
	doins ${FILESDIR}/*.png
	doins ${FILESDIR}/*.flw

	keepdir /etc/mail/anomy-sanitizer
	dosym ${DEST}/anomy.conf /etc/mail/anomy-sanitizer/anomy.conf
}

pkg_postinst() {
	if [ -z "`grep ^sanitizer: ${ROOT}/etc/group`" ]; then
		groupadd sanitizer
	fi

	if [ -z "`grep ^sanitizer: ${ROOT}/etc/shadow`" ]; then
		useradd sanitizer -d ${SANI_WORKDIR} -g sanitizer -s /bin/false
	fi

	if [ -z "`grep ^sanitizer:.*sanitizer /etc/group`" ]; then
		usermod -G sanitizer sanitizer
	fi

		chown -R sanitizer:sanitizer ${ROOT}/${SANI_WORKDIR}
		chmod -R a-rwx,g+X,u+rwX ${ROOT}/${SANI_WORKDIR}
		chown -R sanitizer:sanitizer ${ROOT}/${DEST}
		chmod -R a-rwx,g+rX,u+rX ${ROOT}/${DEST}
		chmod u+x ${ROOT}/${DEST}/bin/*.pl
		chmod u+x ${ROOT}/${DEST}/contrib/*.pl
		chmod u+x ${ROOT}/${DEST}/testcases/*.sh
		chmod u+w ${ROOT}/${DEST}/*
		chmod u+w ${ROOT}/${DEST}/bin
		chmod u+w ${ROOT}/${DEST}/bin/Anomy
		chmod u+w ${ROOT}/${DEST}/bin/Anomy/Sanitizer
		chmod u+w ${ROOT}/${DEST}/contrib
		chmod u+w ${ROOT}/${DEST}/testcases
		chmod u+w ${ROOT}/${DEST}/testcases/results.def

		echo ""
		echo ""
		einfo "There is a howto for the integration of sanitizer"
		einfo "into your (postfix) mail system at"
		einfo "\thttp://advosys.ca/papers/postfix-filtering.html"
		einfo "Please find example scripts to be used to integrate sanitizer"
		einfo "into your (postfix) mail system at"
		einfo "\t${ROOT}/${DEST}"
		einfo "There is also a png and kivio document about a possible"
		einfo "e-mail architecture"
		echo ""
		echo ""
}

pkg_postrm() {
	rm -f ${ROOT}/${DEST}/anomy.conf

	# remove groups and users
	if [ -n "`grep ^sanitizer: ${ROOT}/etc/group`" ]; then
		groupdel sanitizer
	fi

	if [ -n "`grep ^sanitizer: ${ROOT}/etc/shadow`" ]; then
		userdel -r sanitizer
	fi
}
