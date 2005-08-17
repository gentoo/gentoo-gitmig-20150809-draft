# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.1.0_alpha20050718.ebuild,v 1.3 2005/08/17 15:54:30 ka0ttic Exp $

inherit eutils

IUSE="build"

SNAPSHOT=${PV/*_alpha/}
BUGID="102126"

SLOT="0"
DESCRIPTION="Portage ports system"
SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~genone/distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org"
RESTRICT=""

#KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
KEYWORDS="~amd64 ~mips ~x86"

LICENSE="GPL-2"
RDEPEND="!build? ( >=sys-apps/sed-4.0.5
					dev-python/python-fchksum
					>=dev-lang/python-2.3
					sys-apps/debianutils
					>=app-shells/bash-2.05a
					sys-devel/autoconf
					sys-devel/automake
					sys-apps/sandbox )
		 selinux? ( dev-python/python-selinux )"

pkg_setup() {
	eerror "THIS IS A PRE-ALPHA VERSION AND NOT EVEN CLOSE TO RELEASE QUALITY."
	einfo "But to get it closer to release quality we need a lot of testing."
	einfo "If you think you found a bug with one of the new features or a new"
	einfo "bug that's not present in 2.0 please check bug #${BUGID} if it's "
	einfo "already noted there, and if not, add it."
	ewarn "Don't file any new bugs for this version, report everything to "
	ewarn "bug #${BUGID}!"
	ewarn "Last warning: Don't use this if you want a stable system. This is"
	ewarn "highly unfinished software (should work in general though)."
	ebeep
	epause 10
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:VERSION=\"2.0.*\":VERSION=\"${SNAPSHOT}\":" pym/portage.py
}

src_compile() {
	cd ${S}
	autoreconf -i || die "autocrap failed"
	econf || die "configure failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "installation failed"
}

pkg_postinst() {
	#yank old cache files
	if [ -d /var/cache/edb ]
	then
		rm -f /var/cache/edb/xcache.p
		rm -f /var/cache/edb/mtimes
	fi

	for X in ${ROOT}etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${X}" ] && mv -f "${X}" "${ROOT}etc/make.globals"
	done
	eerror "THIS IS A PRE-ALPHA VERSION AND NOT EVEN CLOSE TO RELEASE QUALITY."
	einfo "But to get it closer to release quality we need a lot of testing."
	einfo "If you think you found a bug with one of the new features or a new"
	einfo "bug that's not present in 2.0 please check bug #${BUGID} if it's "
	einfo "already noted there, and if not, add it."
	ewarn "Don't file any new bugs for this version, report everything to "
	ewarn "bug #${BUGID}!"
}
