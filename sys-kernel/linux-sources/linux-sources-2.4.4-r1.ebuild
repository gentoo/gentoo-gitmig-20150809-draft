# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-sources/linux-sources-2.4.4-r1.ebuild,v 1.1 2001/04/28 18:49:57 pete Exp $

#OKV=original kernel version, KV=patched kernel version
OKV=2.4.4
KV=2.4.4
S=${WORKDIR}/linux-${KV}
#Versions of LVM, ALSA, JFS and lm-sensors
LVMV=0.9.1_beta7
LVMVARC=0.9.1_beta7
AV=0.5.10b
JFSV=0.2.1
SENV=2.5.5
RV=20010327
XMLV=0.3
KNV="6.g"

if [ "${PN}" = "linux" ]
then
    DESCRIPTION="Linux kernel version ${KV}, including modules, binary tools, libraries and includes"
elif [ "${PN}" = "linux-sources"
then
    DESCRIPTION="Linux kernel version ${KV} - full sources"
elif [ "${PN}" = "linux-extras" ]
then
    DESCRIPTION="Linux kernel support binary tools and libraries"
fi
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
         http://www.netroedge.com/~lm78/archive/lm_sensors-${SENV}.tar.gz 
         http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-${JFSV}-patch.tar.gz

         ftp://ftp.sistina.com/pub/LVM/0.9.1_beta/lvm_${LVMVARC}.tar.gz"
#	 http://download.sourceforge.net/xmlprocfs/linux-2.4-xmlprocfs-${XMLV}.patch.gz
#	 ftp://ftp.reiserfs.com/pub/reiserfs-for-2.4/linux-${OKV}-reiserfs-${RV}.patch.gz

if [ "`use alsa`" ]
then
    SRC_URI="$SRC_URI ftp://ftp.alsa-project.org/pub/driver/alsa-driver-${AV}.tar.bz2"
fi

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/
	  http://www.alsa-project.org"

if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-sources" ]
then
PROVIDE="virtual/kernel"
fi

RDEPEND=">=sys-apps/reiserfs-utils-3.6.25-r1"

# this is not pretty...
LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
    #unpack kernel and apply reiserfs-related patches
    cd ${WORKDIR}
    unpack linux-${OKV}.tar.bz2
    mv linux linux-${KV}
    cd ${S}
#    echo "Applying ${KV} patch..."
#    try bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1
#    echo "Applying reiserfs-update patch..."
#    try gzip -dc ${DISTDIR}/linux-2.4.2-reiserfs-${RV}.patch.gz | patch -N -p1
#    echo "You can ignore the rejects the changes already are in rc11"

#    echo
#    echo "Applying xmlprocfs patch..."
#    try gzip -dc ${DISTDIR}/linux-2.4-xmlprocfs-${XMLV}.patch.gz | patch -p1   
#    echo "Applying reiserfs-knfsd patch..."
#    try gzip -dc ${DISTDIR}/linux-${OKV}-knfsd-${KNV}.patch.gz | patch -p1
    mkdir ${S}/extras
    #create and apply LVM patch.  The tools get built later.
    cd ${S}/extras
    echo "Unpacking and applying LVM patch..."
    unpack lvm_${LVMVARC}.tar.gz
    cd LVM/${LVMV}
    
    # I had to hack this in so that LVM will look in the current linux
    # source directory instead of /usr/src/linux for stuff - pete
    try CFLAGS=\""${CFLAGS} -I${S}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
    
    cd PATCHES
    try make KERNEL_VERSION=${KV} KERNEL_DIR=${S}
    cd ${S}
    # the -l option allows this patch to apply cleanly (ignore whitespace changes)
    try patch -l -p1 < ${S}/extras/LVM/${LVMV}/PATCHES/lvm-${LVMV}-${KV}.patch
  
    if [ "`use alsa`" ]
    then  
        #unpack alsa drivers
        echo "Unpacking ALSA drivers..."
        cd ${S}/extras
        unpack alsa-driver-${AV}.tar.bz2
    fi
    
    #unpack and apply the lm_sensors patch
    echo "Unpacking and applying lm_sensors patch..."
    cd ${S}/extras
    unpack lm_sensors-${SENV}.tar.gz
    cd lm_sensors-${SENV}
    mkpatch/mkpatch.pl . ${S} > ${S}/lm_sensors-patch
    rmdir src
    ln -s ../.. src
    cp -a Makefile Makefile.orig
    sed -e "s:^LINUX=.*:LINUX=src:" \
        -e "s/^COMPILE_KERNEL.*/COMPILE_CERNEL := 0/" \
        -e "s:^I2C_HEADERS.*:I2C_HEADERS=src/include:" \
        -e "s#^DESTDIR.*#DESTDIR := ${D}#" \
        -e "s#^PREFIX.*#PREFIX := /usr#" \
        -e "s#^MANDIR.*#MANDIR := /usr/share/man#" \
        Makefile.orig > Makefile
    cd ${S}
    patch -p1 < lm_sensors-patch
    
    #get sources ready for compilation or for sitting at /usr/src/linux
    echo "Preparing for compilation..."
    cd ${S}
    #sometimes we have icky kernel symbols; this seems to get rid of them
    try make mrproper
    #this is the configuration for the default kernel
    try cp ${FILESDIR}/${KV}/config.bootcomp .config
    try yes \"\" | make oldconfig
    try make include/linux/version.h
    #fix silly permissions in tarball
    cd ${WORKDIR}
    chown -R 0.0 ${S}
    chmod -R a+r-w+X,u+w ${S}
}

src_compile() {
    
    if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-sources" ]
    then
	try make symlinks
	
	#LVM tools are included in the linux and linux-extras pakcages
	cd ${S}/extras/LVM/${LVMV}
	
	# I had to hack this in so that LVM will look in the current linux
	# source directory instead of /usr/src/linux for stuff - pete
	try CFLAGS=\""${CFLAGS} -I${S}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
	
	try make
	
	cd ${S}/extras/lm_sensors-${SENV}
	try make
	
	cd ${S}

	if [ "$PN" == "linux" ]
	then
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" dep
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" bzImage
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" modules
	    
	fi
	if [ "`use alsa`" ]
	then
	    cd ${S}/extras/alsa-driver-${AV}
	    try ./configure --with-kernel=\"${S}\" --with-isapnp=yes --with-sequencer=yes --with-oss=yes --with-cards=all
	    try make
	fi
    fi
}

src_install() {
    dodir /usr/src
    
    if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-extras" ]
    then
	dodir /usr/lib
	cd ${S}/extras/LVM/${LVMV}/tools
	
	try CFLAGS=\"${CFLAGS} -I${S}/include\" make install -e prefix=${D} mandir=${D}/usr/share/man \
	    sbindir=${D}/sbin libdir=${D}/lib
	#no need for a static library in /lib
	mv ${D}/lib/liblvm*.a ${D}/usr/lib
	
	#install sensors tools
	cd ${S}/extras/lm_sensors-${SENV}
	make install
	
        #install ALSA progs
        cd ${S}/extras/alsa-driver-${AV}
        into /usr
        dosbin snddevices
	
	if [ "$PN" = "linux" ]
	then
 	    if [ "`use alsa`" ]
            then
  	        #install ALSA modules
 	        cd ${S}/extras/alsa-driver-${AV}
	        dodir /lib/modules/${KV}/misc
	        cp modules/*.o ${D}/lib/modules/${KV}/misc
	
            fi
	    
	    dodir /usr/src/linux-${KV}
	    cd ${D}/usr/src
	    #grab includes and documentation only
#	    dodir /usr/src/linux-${KV}/include/linux
#	    dodir /usr/src/linux-${KV}/include/asm-i386
	    cp -ax ${S}/include ${D}/usr/src/linux-${KV}
	    cp -ax ${S}/Documentation ${D}/usr/src/linux-${KV}
#	    dodir /usr/include
#	    dosym ../src/linux/include/linux /usr/include/linux
#	    dosym ../src/linux/include/asm-i386 /usr/include/asm
	    
	    #grab compiled kernel
	    dodir /boot/boot
	    insinto /boot/boot
	    cd ${S}
	    doins arch/i386/boot/bzImage
	    
	    #grab modules
	    # Do we have a bug in modutils ?
	    # Meanwhile we use this quick fix (achim)
	    
	    install -d ${D}/lib/modules/`uname -r`
	    try make INSTALL_MOD_PATH=${D} modules_install
#	    rm -r ${D}/lib/modules/`uname -r`		

	    #fix symlink
	    cd ${D}/lib/modules/${KV}
	    rm build
	    ln -sf /usr/src/linux-${KV} build
	fi
    elif [ "${PN}" = "linux-sources" ]
    then
	cd ${S}
	make mrproper
	cd ${WORKDIR}
	
	cd ${S}/extras/LVM/${LVMV}
	make distclean
	
	cd ${S}/extras/lm_sensors-${SENV}
	make clean
	cp -ax ${S} ${D}/usr/src
    fi
	
    if [ "`use alsa`" ]
    then
	# get alsa includes
	cd ${S}/extras/alsa-driver-${AV}
	insinto /usr/src/linux-${KV}/include/linux
	cd include
	doins asound.h asoundid.h asequencer.h ainstr_*.h
    fi 
}

pkg_postinst() {
    if [  "${ROOT}" = "/" ]
    then
	if [ "`use alsa`"  ] ; then
	    echo "Creating sounddevices..."
	    /usr/sbin/snddevices
		#needs to get fixed for devfs
	fi
    fi
    rm -f ${ROOT}/usr/src/linux
    ln -sf linux-${KV} ${ROOT}/usr/src/linux
}

pkg_postrm() {
    rm -rf ${ROOT}/usr/src/linux ${ROOT}/usr/src/linux-${KV}
}
