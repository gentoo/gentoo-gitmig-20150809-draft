# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-sources-vanilla/linux-sources-vanilla-2.4.7.ebuild,v 1.5 2001/08/18 19:05:49 danarmak Exp $

S=${WORKDIR}/linux-${PV}

SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${PV}.tar.bz2"

PROVIDE="virtual/kernel"

HOMEPAGE="http://www.kernel.org/"

DEPEND=">=sys-apps/modutils-2.4.2 sys-devel/perl" # !!!what's perl for?

# !!! Do we keep these *utils in RDEPEND?
#ncurses is required for "make menuconfig"
RDEPEND=">=sys-apps/e2fsprogs-1.22
	 >=sys-apps/util-linux-2.11f
	 >=sys-apps/reiserfs-utils-3.6.25-r1
	 >=sys-libs/ncurses-5.2"

LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {

    cd ${WORKDIR}
    unpack linux-${PV}.tar.bz2
    
    mv linux linux-${PV}

    #fix silly permissions in tarball
    chown -R 0.0 *
    chmod -R a+r-w+X,u+w *
    
}
		
src_compile() {
    
    cd ${S}
    
    # does this have any effect?
    try make mrproper
    
    # create default config
    try yes "" | make config
    echo "Ignore any errors from the yes command above."
    
    cd ${S}
    # try without the hostflags thing sometime and see what happens
    try make HOSTCFLAGS="${LINUX_HOSTCFLAGS}" dep
    try make symlinks

}

src_install() {

    cd ${WORKDIR}
    dodir /usr/src
    mv linux-${PV} ${D}/usr/src
    
}

pkg_preinst() {

    if [ -L ${ROOT}usr/include/linux ]
    then
	rm ${ROOT}usr/include/linux
    fi
    
    if [ -L ${ROOT}usr/include/asm ]
    then
	rm ${ROOT}usr/include/asm
    fi

}

pkg_postinst() {

    rm -f ${ROOT}/usr/src/linux
    ln -sf linux-${PV} ${ROOT}/usr/src/linux
    
}
