# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/anomy-sanitizer/anomy-sanitizer-1.76-r1.ebuild,v 1.1 2006/02/20 21:19:53 mcummings Exp $

inherit eutils

DESCRIPTION="Perl based e-mail filtering tool, sensitive to html tags, mime types and attachments"
HOMEPAGE="http://mailtools.anomy.net/"
SRC_URI="http://mailtools.anomy.net/dist/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
		>=virtual/perl-MIME-Base64-2.12-r2
		>=dev-perl/Mail-Audit-2.1-r1
		dev-perl/Convert-TNEF
		dev-perl/MIME-tools
		dev-perl/libwww-perl
		virtual/mta"

S="${WORKDIR}/anomy"
DEST="/usr/share/${PN}"
SANI_WORKDIR="/var/spool/sanitizer"
SANI_CONFDIR="/etc/mail/${PN}"

src_install() {
	dodoc *.sanitizer CREDITS UNICODE.TXT
	dohtml sanitizer.html
	rm -rf "${S}/contrib/.tmp"
	rm -f *.sanitizer CREDITS UNICODE.TXT sanitizer.html
	mv "${S}/contrib" "${D}/usr/share/doc/${PF}/"

	insinto /usr/share/doc/${PF}/examples
	doins ${FILESDIR}/*.{sh,png,flw}

	keepdir ${SANI_CONFDIR}
	insinto ${SANI_CONFDIR}
	doins ${FILESDIR}/*.conf

	keepdir ${SANI_WORKDIR}
	dodir ${DEST}
	insinto ${DEST}

# generate lists for doins
	_list="anomy anomy/bin anomy/bin/Anomy anomy/bin/Anomy/Sanitizer anomy/testcases anomy/testcases/results.def"

	for i in $_list; do
		_di=`echo $i | sed -e "s/^anomy//g; s/^\///g"` &>/dev/null
		insinto ${DEST}/$_di

		_sublist=`find ${WORKDIR}/$i/* -type f -maxdepth 0`
		for l in $_sublist; do
			echo &>/dev/null
			doins $l
		done
	done

	dosym ${SANI_CONFDIR}/anomy.conf ${DEST}/anomy.conf
}

pkg_preinst() {
	enewgroup sanitizer
	enewuser sanitizer -1 -1 ${SANI_WORKDIR} sanitizer
}

pkg_postinst() {
		chown -R sanitizer:sanitizer ${ROOT}/${SANI_WORKDIR}
		chmod -R a-rwx,g+X,u+rwX ${ROOT}/${SANI_WORKDIR}
		chown -R sanitizer:sanitizer ${ROOT}/${DEST}
		chmod -R a-rwx,g+rX,u+rX ${ROOT}/${DEST}
		chown sanitizer:sanitizer ${ROOT}/${SANI_CONFDIR}/anomy.conf
		chmod 0640 ${ROOT}/${SANI_CONFDIR}/anomy.conf
		chmod u+x ${ROOT}/${DEST}/bin/*.pl
		chmod u+x ${ROOT}/${DEST}/testcases/*.sh
		chmod u+w ${ROOT}/${DEST}/*
		chmod u+w ${ROOT}/${DEST}/bin
		chmod u+w ${ROOT}/${DEST}/bin/Anomy
		chmod u+w ${ROOT}/${DEST}/bin/Anomy/Sanitizer
		chmod u+w ${ROOT}/${DEST}/testcases
		chmod u+w ${ROOT}/${DEST}/testcases/results.def

		einfo ""
		einfo "There is a howto for the integration of sanitizer"
		einfo "into your (postfix) mail system at"
		einfo "http://advosys.ca/papers/postfix-filtering.html"
		einfo "Please find example scripts to be used to integrate sanitizer"
		einfo "into your (postfix) mail system at"
		einfo "/usr/share/doc/${PF}/examples"
		einfo "There is also a png and kivio document about a possible"
		einfo "e-mail architecture"
		einfo ""

}

pkg_postrm() {
	einfo "After unmerging this ebuild, you will have to remove"
	einfo "created user and group manually. To do so, run:"
	einfo "userdel -r sanitizer; groupdel sanitizer"
}
