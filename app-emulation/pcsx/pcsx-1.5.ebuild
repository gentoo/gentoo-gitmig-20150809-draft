# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pcsx/pcsx-1.5.ebuild,v 1.1 2003/05/27 06:41:26 msterret Exp $

S=${WORKDIR}/PcsxSrc-${PV}
DESCRIPTION="Playstation emulator"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://www.pcsx.net/downloads/PcsxSrc-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="opengl"

if [ "`use opengl`" ] ; then
	GLDEPEND="app-emulation/psemu-gpupetemesagl"
else
	GLDEPEND="app-emulation/psemu-peopssoftgpu"
fi

DEPEND="sys-libs/zlib
		>=sys-apps/sed-4
        app-arch/unzip
        x11-libs/gtk+
        gnome-base/libglade"

RDEPEND="app-emulation/psemu-cdr
         app-emulation/psemu-cdriso
         app-emulation/psemu-padxwin
         app-emulation/psemu-padjoy
         app-emulation/psemu-peopsspu
         ${GLDEPEND}"

src_unpack() {
	unpack PcsxSrc-${PV}.tgz

	# Change some hard-coded defaults...
	sed -i \
		-e 's:Plugin/:/usr/lib/psemu/plugins/:' \
	    -e 's:Bios/:/usr/lib/psemu/bios/:' \
	    -e 's:Pcsx.cfg:~/.pcsx/config:' \
	    ${S}/Linux/LnxMain.c || die "sed LnxMain.c failed"

	for f in `find ${S} -regex '.*\.[ch]'` ; do
		sed -i -e 's/$//' ${f} || die "sed ${f} failed"
	done
}
src_compile() {
	cd Linux && \
	econf && \
	emake CC=gcc OPTIMIZE="${CFLAGS} -fPIC -fomit-frame-pointer -finline-functions -ffast-math" || die "emake failed"
	mv pcsx pcsx.bin
}

src_install() {
	dobin ${S}/Linux/pcsx.bin
	dobin ${FILESDIR}/pcsx
	dodoc ${S}/Docs/*
}
