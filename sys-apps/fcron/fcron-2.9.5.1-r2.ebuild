# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fcron/fcron-2.9.5.1-r2.ebuild,v 1.3 2005/02/15 14:04:21 ka0ttic Exp $

inherit cron

DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/archives/${P}.src.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~hppa ~amd64"
IUSE="pam doc selinux"

DEPEND="virtual/editor
	doc? ( >=app-text/docbook-dsssl-stylesheets-1.77 )
	selinux? ( sys-libs/libselinux )
	pam? ( >=sys-libs/pam-0.77 )"

pkg_setup() {
	# bug #65263
	# fcron's ./configure complains if EDITOR is not set to an absolute path,
	# so try to set it to the abs path if it isn't
	if [[ "${EDITOR}" != */* ]] ; then
		einfo "Attempting to deduce absolute path of ${EDITOR}"
		EDITOR=$(which ${EDITOR} 2>/dev/null)
		if [ ! -x "${EDITOR}" ] ; then
			die "Please set the EDITOR env variable to the path of a valid executable."
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.0.0-configure.diff
	# respect LDFLAGS
	sed -i "s:\(@LIBS@\):\$(LDFLAGS) \1:" Makefile.in || die "sed failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	local myconf
	use doc && \
		myconf="--with-dsssl-dir=/usr/share/sgml/stylesheets/dsssl/docbook"

	# QA security notice fix; see "[gentoo-core] Heads up changes in suid
	# handing with portage >=51_pre21" for more details.
	append-ldflags -Wl,-z,now

	econf \
		$(use_with pam) \
		$(use_with selinux) \
		--with-username=cron \
		--with-groupname=cron \
		--with-piddir=/var/run \
		--with-etcdir=/etc/fcron \
		--with-spooldir=/var/spool/cron \
		--with-fifodir=/var/run \
		--with-sendmail=/usr/sbin/sendmail \
		--with-fcrondyn=yes \
		--with-editor=${EDITOR} \
		${myconf} \
		|| die "Configure problem"

	emake || die "Compile problem"
}

src_install() {
	docrondir /var/spool/cron/fcrontabs -m0770 -o cron -g cron
	docron fcron -m0110 -o root -g root
	docrontab fcrontab -m6110 -o cron -g cron

	insinto /usr/bin
	insopts -o root -g cron -m6110 ; doins fcronsighup
	insopts -o cron -g cron -m6110 ; doins fcrondyn

	# /etc stuff
	insinto /etc/fcron
	insopts -m 640 -o root -g cron
	doins ${FILESDIR}/fcron.{allow,deny}
	newins ${FILESDIR}/fcron.conf-${PV} fcron.conf

	newpamd ${FILESDIR}/fcron.pam fcron
	newpamd ${FILESDIR}/fcrontab.pam fcrontab

	insinto /etc
	doins ${FILESDIR}/crontab
	newinitd ${FILESDIR}/fcron.rc6 fcron

	# doc stuff
	dodoc MANIFEST VERSION doc/txt/*.txt
	newdoc ${FILESDIR}/fcron.conf-${PV} fcron.conf.sample
	use doc && dohtml doc/HTML/*.html
	dodoc ${FILESDIR}/crontab

	doman doc/man/*.{1,3,5,8}
}

pkg_postinst() {
	einfo "Each user who uses fcron should be added to the cron group"
	einfo "in /etc/group and also be added in /etc/fcron/fcron.allow"
	cron-pkg_postinst
}
