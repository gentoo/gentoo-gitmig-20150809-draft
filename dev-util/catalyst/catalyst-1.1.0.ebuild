# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-1.1.0.ebuild,v 1.1 2004/10/22 04:30:53 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Gentoo Linux official release metatool"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~wolf31o2/sources/catalyst/${P}.tar.bz2"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="doc cdr"

DEPEND=""
RDEPEND="dev-lang/python
	sys-apps/portage
	dev-util/ccache
	amd64? ( sys-apps/linux32 )
	cdr? ( app-cdr/cdrtools app-misc/zisofs-tools sys-fs/squashfs-tools )
	>=sys-kernel/genkernel-3.1.0"

S=${WORKDIR}/${PN}

src_install() {
	insinto /usr/lib/${PN}/arch
	doins arch/*
	insinto /usr/lib/${PN}/modules
	doins modules/*
	insinto /usr/lib/${PN}/livecd/kconfig
	doins livecd/kconfig/*
	insinto /usr/lib/${PN}/livecd/cdtar
	doins livecd/cdtar/*
	exeinto /usr/lib/${PN}/livecd/isogen
	doexe livecd/isogen/*
	exeinto /usr/lib/${PN}/livecd/runscript
	doexe livecd/runscript/*
	exeinto /usr/lib/${PN}/livecd/runscript-support
	doexe livecd/runscript-support/*
	insinto /usr/lib/${PN}/livecd/files
	doins livecd/files/*
	for x in targets/*
	do
		exeinto /usr/lib/${PN}/$x
		doexe $x/*
	done
	exeinto /usr/lib/${PN}
	doexe catalyst
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
