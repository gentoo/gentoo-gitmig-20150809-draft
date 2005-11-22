# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-2.0_pre20051122.ebuild,v 1.1 2005/11/22 15:55:14 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Gentoo Linux official release metatool"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst"
SRC_URI="http://dev.gentoo.org/~wolf31o2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2.0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="doc ccache cdr examples"

DEPEND=""
RDEPEND="dev-lang/python
	amd64? (
		sys-apps/linux32 )
	ppc64? (
		sys-devel/ppc32 )
	ccache? (
		dev-util/ccache )
	cdr? (
		virtual/cdrtools
		app-misc/zisofs-tools
		!mips? ( >=sys-fs/squashfs-tools-2.1 ) )
	examples? (
		dev-util/livecd-kconfigs
		dev-util/livecd-specs )"

pkg_setup() {
	if use ccache
	then
		einfo "Enabling ccache support for catalyst."
	else
		ewarn "By default, ccache support for catalyst is disabled."
		ewarn "If this is not what you intended,"
		ewarn "then you should add ccache to your USE."
	fi
	if use examples || use doc
	then
		ewarn "The examples and documentation in this experimental ebuild have"
		ewarn "not been fully updated.  Please use the gentoo-catalyst mailing"
		ewarn "list if you have any issues with this build."
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-slot.patch
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
	if use doc;	then
		DOCDESTTREE="." dohtml -A spec,msg,example -r examples files
	fi
	dodoc README ChangeLog ChangeLog.old AUTHORS
	newman files/catalyst.1 catalyst2.1
	# This will go away in the future
	dosed "s:/usr/lib/catalyst:/usr/lib/catalyst2:" /etc/catalyst2/catalyst2.conf
	dosed "s:/var/tmp/catalyst:/var/tmp/catalyst2:" /etc/catalyst2/catalyst2.conf
}

pkg_postinst() {
	echo
	einfo "You can find more information about catalyst by checking out the"
	einfo "catalyst project page at:"
	einfo "http://www.gentoo.org/proj/en/releng/catalyst/index.xml"
	echo
}
