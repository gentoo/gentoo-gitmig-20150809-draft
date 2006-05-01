# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-2.0_rc45.ebuild,v 1.1 2006/05/01 19:47:05 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Gentoo Linux official release metatool"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst"
SRC_URI="http://dev.gentoo.org/~wolf31o2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="ccache cdr"

DEPEND=""
RDEPEND="dev-lang/python
	app-crypt/shash
	amd64? ( sys-apps/setarch )
	ppc64? ( sys-apps/setarch )
	ccache? ( dev-util/ccache )
	cdr? (
		virtual/cdrtools
		ia64? ( sys-fs/dosfstools )
		app-misc/zisofs-tools
		>=sys-fs/squashfs-tools-2.1
	)
	examples? (
		dev-util/livecd-kconfigs
		dev-util/livecd-specs )"

pkg_setup() {
	if use ccache ; then
		einfo "Enabling ccache support for catalyst."
	else
		ewarn "By default, ccache support for catalyst is disabled."
		ewarn "If this is not what you intended,"
		ewarn "then you should add ccache to your USE."
	fi
	echo
	einfo "The template spec files are now installed by default.  You can find"
	einfo "them under /usr/share/doc/${PF}/examples"
	einfo "and they are considered to be the authorative source of information"
	einfo "on catalyst."
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-slot.patch
}

src_install() {
	ewarn "This version of the ebuild is slotted to allow side-by-side"
	ewarn "installation with catalyst 1.x for use on build servers.  The final"
	ewarn "version of this ebuild will not be slotted, as catalyst 2.0 is to"
	ewarn "supercede catalyst 1.x in every way.  It is currently slotted for"
	ewarn "testing purposes only."
	insinto /usr/lib/${PN}2/arch
	doins arch/* || die "copying arch/*"
	insinto /usr/lib/${PN}2/modules
	doins modules/* || die "copying modules/*"
	insinto /usr/lib/${PN}2/livecd/cdtar
	doins livecd/cdtar/* || die "copying cdtar/*"
	insinto /usr/lib/${PN}2/livecd/files
	doins livecd/files/* || die "copying files/*"
	for x in targets/*; do
		exeinto /usr/lib/${PN}2/$x
		doexe $x/* || die "copying ${x}"
	done
	exeinto /usr/lib/${PN}2
	newexe catalyst catalyst2 || die "copying catalyst"
	dodir /usr/bin
	dosym /usr/lib/${PN}2/catalyst2 /usr/bin/catalyst2
	insinto /etc/catalyst2
	newins files/catalyst.conf catalyst2.conf
	DOCDESTTREE="." dohtml -A spec,msg,example -r examples files
	dodoc README ChangeLog ChangeLog.old AUTHORS
	newman files/catalyst.1 catalyst2.1
	# This will go away in the future
	dosed "s:/usr/lib/catalyst:/usr/lib/catalyst2:" \
		/etc/catalyst2/catalyst2.conf
	dosed "s:/var/tmp/catalyst:/var/tmp/catalyst2:" \
		/etc/catalyst2/catalyst2.conf
	# Here is where we actually enable ccache
	use ccache && \
		dosed 's:options="autoresume kern:options="autoresume ccache kern:' \
		/etc/catalyst2/catalyst2.conf
}

pkg_postinst() {
	echo
	einfo "You can find more information about catalyst by checking out the"
	einfo "catalyst project page at:"
	einfo "http://www.gentoo.org/proj/en/releng/catalyst/index.xml"
	echo
}
