# Copyright 1999-2004 Gentoo Foundation, Pieter Van den Abeele <pvdabeel@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsystem/libsystem-7.1.ebuild,v 1.6 2004/07/12 08:49:20 pvdabeel Exp $

DESCRIPTION="Darwin Libsystem, a collection of core libs similar to glibc on linux"

HOMEPAGE="http://www.opensource.apple.com/darwinsource/"
SRC_URI=""
LICENSE="APSL-2"
SLOT="0"
KEYWORDS="-* macos"
IUSE=""
PROVIDE="virtual/libc"

# I haven't listed any deps here, we're currently not building Darwin from scratch yet.
# For now, this is a dummy package provided upstream. The version provided by the
# distributor is pinpointed in the users profile

DEPEND=""
RDEPEND=""

src_unpack() {
	mkdir -p ${S}
}

src_compile() {
	true
}

src_install() {
	true
}
