# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-1.1.8.ebuild,v 1.3 2005/04/01 18:40:44 gustavoz Exp $

inherit eutils

DESCRIPTION="Gentoo Linux official release metatool"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/catalyst/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 ~s390 sparc x86"
IUSE="doc ccache cdr"

DEPEND=""
RDEPEND="dev-lang/python
	sys-apps/portage
	amd64? ( sys-apps/linux32 )
	ccache? ( dev-util/ccache )
	cdr? ( virtual/cdrtools app-misc/zisofs-tools >=sys-fs/squashfs-tools-2.1 )"

pkg_setup() {
	if use ccache; then
		einfo "Enabling ccache support for catalyst."
	else
		ewarn "Disabling ccache support for catalyst.  If this is not what you intended,"
		ewarn "then you should add ccache to your USE."
	fi
}

src_install() {
	insinto /usr/lib/${PN}/arch
	doins arch/* || die "copying arch/*"
	insinto /usr/lib/${PN}/modules
	doins modules/* || die "copying modules/*"
	insinto /usr/lib/${PN}/livecd/cdtar
	doins livecd/cdtar/* || die "copying cdtar/*"
	exeinto /usr/lib/${PN}/livecd/isogen
	doexe livecd/isogen/* || die "copying isogen/*"
	exeinto /usr/lib/${PN}/livecd/runscript
	doexe livecd/runscript/* || die "copying runscript/*"
	exeinto /usr/lib/${PN}/livecd/runscript-support
	doexe livecd/runscript-support/* || die "copying runscript-support/*"
	insinto /usr/lib/${PN}/livecd/files
	doins livecd/files/* || die "copying files/*"
	for x in targets/*
	do
		exeinto /usr/lib/${PN}/$x
		doexe $x/* || die "copying ${x}"
	done
	exeinto /usr/lib/${PN}
	doexe catalyst || die "copying catalyst"
	dodir /usr/bin
	dosym /usr/lib/${PN}/catalyst /usr/bin/catalyst
	insinto /etc/catalyst
	doins files/catalyst.conf
	if use doc
	then
		DOCDESTTREE="." dohtml -A spec,msg -r examples files
	fi
	dodoc TODO README ChangeLog ChangeLog.old AUTHORS COPYING REMARKS
	doman files/catalyst.1
}
