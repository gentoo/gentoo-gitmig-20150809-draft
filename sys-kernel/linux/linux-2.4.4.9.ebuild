# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# /home/cvsroot/gentoo-x86/sys-kernel/linux/linux-2.4.4.3.ebuild,v 1.1 2001/05/02 14:31:06 achim Exp

#OKV=original kernel version, KV=patched kernel version
OKV=2.4.4
KV=2.4.4-ac9
S=${WORKDIR}/linux-${KV}

# Versions of LVM
LVMV=0.9.1_beta7

LVMVARC=0.9.1_beta7
# Versions of alsa
AV=0.5.11

# Versionos of jfs
JFSV=0.2.1

# Versions of lm_sensors
SENV=2.5.5

# Versions of reiserfs
RV=20010327
KNV="6.g"
PIV="1.d"

# Versions of xmlprocfs
XMLV=0.3

# Versions of pcmcia-cs
PCV="3.1.26"

[ "${PN}" = "linux" ] && DESCRIPTION="Linux kernel version ${KV}, including modules, binary tools, libraries and includes"
[ "${PN}" = "linux-sources" ] && DESCRIPTION="Linux kernel version ${KV} - full sources"
[ "${PN}" = "linux-extras" ] && DESCRIPTION="Linux kernel support tools and libraries"

# We use build in /usr/src/linux in case of linux-extras
# so we need no sources
if [ ! "$PN" = "linux-extras" ] ; then
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/people/alan/2.4/patch-${KV}.bz2
	 http://dice.mfa.kfki.hu/download/reiserfs-3.6.25-2.4.4/linux-2.4.4-knfsd-6.g.patch.gz
	 http://dice.mfa.kfki.hu/download/reiserfs-3.6.25-2.4.4/linux-2.4.4-procinfo-1.d.patch.gz
	 http://dice.mfa.kfki.hu/download/reiserfs-3.6.25-2.4.4/reiserfs-quota-2.4.4.dif.bz2"

#        http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-${JFSV}-patch.tar.gz
#	 http://download.sourceforge.net/xmlprocfs/linux-2.4-xmlprocfs-${XMLV}.patch.gz
#	 ftp://ftp.reiserfs.com/pub/reiserfs-for-2.4/linux-${OKV}-reiserfs-${RV}.patch.gz

if [ "`use lm_sensors`" ] ; then
    SRC_URI="${SRC_URI} http://www.netroedge.com/~lm78/archive/lm_sensors-${SENV}.tar.gz"
fi
if [ "`use lvm`" ] ; then
    SRC_URI="${SRC_URI} ftp://ftp.sistina.com/pub/LVM/0.9.1_beta/lvm_${LVMVARC}.tar.gz"
fi
if [ "`use alsa`" ] ; then 
    SRC_URI="${SRC_URI} ftp://ftp.alsa-project.org/pub/driver/alsa-driver-${AV}.tar.bz2"
    if [ "$PN" = "linux" ] ; then
	PROVIDE="virtual/kernel virtual/alsa"
    else
	PROVIDE="virtual/kernel"
    fi
fi
if [ "`use pcmcia-cs`" ] ; then
    SRC_URI="${SRC_URI} http://prdownloads.sourceforge.net/pcmcia-cs/pcmcia-cs-${PCV}.tar.gz"
fi

else
    if [ "`use alsa`" ] ; then
	PROVIDE="virtual/alsa"
    fi
fi

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/
	  http://www.alsa-project.org
	  http://pcmcia-cs.sourceforge.net"



if [ ! $PN = "linux-extras" ] ; then
    RDEPEND=">=sys-apps/reiserfs-utils-3.6.25-r1"
    DEPEND=">=sys-apps/modutils-2.4.2"
#else
#    DEPEND=">=sys-kernel/linux-sources-${PV}_${PR}"
fi

# this is not pretty...
LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {

    # We only need to unpack for linux and linux-sources

    if [ ! "$PN" = "linux-extras" ] ; then

    #unpack kernel and apply reiserfs-related patches
    cd ${WORKDIR}
    unpack linux-${OKV}.tar.bz2
    try mv linux linux-${KV}
    cd ${S}
    echo "Applying ${KV} patch..."
    try bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1
#    echo "Applying reiserfs-update patch..."
#    try gzip -dc ${DISTDIR}/linux-2.4.2-reiserfs-${RV}.patch.gz | patch -N -p1
#    echo "You can ignore the rejects the changes already are in rc11"

#    echo
#    echo "Applying xmlprocfs patch..."
#    try gzip -dc ${DISTDIR}/linux-2.4-xmlprocfs-${XMLV}.patch.gz | patch -p1   
    echo "Applying ac-nfsfh patch..."
    try patch -p0 < ${FILESDIR}/${KV}/nfsfh-ac-fix.diff
    echo "Applying reiserfs-knfsd patch..."
    try gzip -dc ${DISTDIR}/linux-${OKV}-knfsd-${KNV}.patch.gz | patch -p1
    echo "Applying ac-nfsfh-knfsd patch..."
    try patch -p0 < ${FILESDIR}/${KV}/nfsfh-ac-knfsd.diff
    echo "Applying reiserfs-procinfo patch..."
    try gzip -dc ${DISTDIR}/linux-${OKV}-procinfo-${PIV}.patch.gz | patch -p1
#    echo "Applying reiserfs-quota patch..."
#    try bzip2 -dc ${DISTDIR}/reiserfs-quota-${OKV}.dif.bz2 | patch -p1
    
    if [ "`use lvm`" ] || [ "`use alsa`" ] || [ "`use lm_sensors`" ] || [ "`use pcmcia-cs`" ]
    then
	mkdir ${S}/extras
    fi
    
    if [ "`use lvm`" ]
    then
	#create and apply LVM patch.  The tools get built later.
	cd ${S}/extras
	echo "Unpacking and applying LVM patch..."
	unpack lvm_${LVMVARC}.tar.gz
	try cd LVM/${LVMV}
	
	# I had to hack this in so that LVM will look in the current linux
	# source directory instead of /usr/src/linux for stuff - pete
	try CFLAGS=\""${CFLAGS} -I${S}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
	
	cd PATCHES
	try make KERNEL_VERSION=${KV} KERNEL_DIR=${S}
	cd ${S}
	# the -l option allows this patch to apply cleanly (ignore whitespace changes)
	try patch -l -p1 < ${S}/extras/LVM/${LVMV}/PATCHES/lvm-${LVMV}-${KV}.patch
	cd ${S}/drivers/md
	try patch -p0 < ${FILESDIR}/${KV}/lvm.c.diff
    fi
    
    if [ "`use alsa`" ]
    then  
        #unpack alsa drivers
        echo "Unpacking ALSA drivers..."
        cd ${S}/extras
        unpack alsa-driver-${AV}.tar.bz2
    fi
    
    if [ "`use lm_sensors`" ]
    then
	#unpack and apply the lm_sensors patch
	echo "Unpacking and applying lm_sensors patch..."
	cd ${S}/extras
	unpack lm_sensors-${SENV}.tar.gz
	try cd lm_sensors-${SENV}
	try mkpatch/mkpatch.pl . ${S} > ${S}/lm_sensors-patch
	try rmdir src
	try ln -s ../.. src
	try cp -a Makefile Makefile.orig

	cd ${S}
	try patch -p1 < lm_sensors-patch
    fi
    if [ "`use pcmcia-cs`" ]
    then
	echo "Unpacking pcmcia-cs tools..."
	cd ${S}/extras
	unpack pcmcia-cs-${PCV}.tar.gz
        patch -p0 < ${FILESDIR}/${KV}/pcmcia-cs-${PCV}-gentoo.diff
    fi
    #get sources ready for compilation or for sitting at /usr/src/linux
    echo "Preparing for compilation..."
    cd ${S}
    #sometimes we have icky kernel symbols; this seems to get rid of them
    try make mrproper
    if [ "${PN}" = "linux" ]
    then
	#this is the configuration for the default kernel
	try cp ${FILESDIR}/${KV}/config.bootcomp .config
	try yes \"\" \| make oldconfig
	echo "Ignore any errors from the yes command above."
	try make include/linux/version.h
    fi
    #fix silly permissions in tarball
    cd ${WORKDIR}
    chown -R 0.0 ${S}
    chmod -R a+r-w+X,u+w ${S}

    fi
}

src_compile() {

    if [ ! "${PN}" = "linux-sources" ] ; then
    if [ $PN = "linux-extras" ] ; then
        KS=/usr/src/linux
    else
        KS=${S}
    fi
	if [ "$PN" = "linux" ] ; then
	    try make symlinks
	fi
	
	if [ "`use lvm`" ]
	then
	    #LVM tools are included in the linux and linux-extras pakcages
	    cd ${KS}/extras/LVM/${LVMV}

	    # This is needed for linux-extras
	    if [ -f "Makefile" ] ; then
		try make clean
	    fi
	    # I had to hack this in so that LVM will look in the current linux
	    # source directory instead of /usr/src/linux for stuff - pete
	    try CFLAGS=\""${CFLAGS} -I${KS}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${KS}"
	    
	    try make 
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    cd ${KS}/extras/lm_sensors-${SENV}
 	    try sed -e \"s:^LINUX=.*:LINUX=src:\" \
	    -e \"s/^COMPILE_KERNEL.*/COMPILE_KERNEL := 0/\" \
	    -e \"s:^I2C_HEADERS.*:I2C_HEADERS=src/include:\" \
	    -e \"s#^DESTDIR.*#DESTDIR := ${D}#\" \
	    -e \"s#^PREFIX.*#PREFIX := /usr#\" \
	    -e \"s#^MANDIR.*#MANDIR := /usr/share/man#\" \
	    Makefile.orig > Makefile

	    try make
	fi
	
	cd ${S}
	
	if [ "$PN" == "linux" ]
	then
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" dep
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" bzImage
		#LEX=\""flex -l"\" bzImage
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" modules
		#LEX=\""flex -l"\" modules
	fi
	    
	# This must come after the kernel compilation in linux
        if [ "`use alsa`" ]
        then
   	    cd ${KS}/extras/alsa-driver-${AV}
	    # This is needed for linux-extras
	    if [ -f "Makefile.conf" ] ; then
		try make clean
	    fi
	    try ./configure --with-kernel=\"${KS}\" --with-isapnp=yes --with-sequencer=yes --with-oss=yes --with-cards=all
	    try make
	fi
	if [ "`use pcmcia-cs`" ]
	then
	    cd ${KS}/extras/pcmcia-cs-${PCV}
	    # This is needed for linux-extras
	    if [ -f "Makefile" ] ; then
		try make clean
	    fi
	    try ./Configure -n --kernel=${KS} --moddir=/lib/modules/${KV} \
		--notrust --cardbus --nopnp --noapm --srctree --sysv --rcdir=/etc/rc.d/
	    try make all
	fi
    fi
}

src_install() {

    if [ $PN = "linux-extras" ] ; then
        KS=/usr/src/linux
    else
        KS=${S}
    fi
    # We install the alsa headers in all three packages
    if [ "`use alsa`" ]
	then
	# get alsa includes
	cd ${KS}/extras/alsa-driver-${AV}
	insinto /usr/src/linux-${KV}/include/linux
	cd include
	doins asound.h asoundid.h asequencer.h ainstr_*.h
    fi

    if [ ! "${PN}" = "linux-sources" ]
    then
	if [ $PN = "linux" ] ; then
	    KS=${S}
	else
	    KS=/usr/src/linux
	fi
	dodir /usr/lib
	
	if [ "`use lvm`" ]
	then
	    cd ${KS}/extras/LVM/${LVMV}/tools
	    
	    try CFLAGS=\""${CFLAGS} -I${KS}/include"\" make install -e prefix=${D} mandir=${D}/usr/share/man \
		sbindir=${D}/sbin libdir=${D}/lib
	    #no need for a static library in /lib
	    mv ${D}/lib/*.a ${D}/usr/lib
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    echo "Install sensor tools..."
	    #install sensors tools
	    cd ${KS}/extras/lm_sensors-${SENV}
	    make install
	fi
	
	if [ "${PN}" = "linux" ] 
	then
	    dodir /usr/src
    	    

	    dodir /usr/src/linux-${KV}
	    cd ${D}/usr/src
	    #grab includes and documentation only
	    echo ">>> Copying includes and documentation..."
	    cp -ax ${S}/include ${D}/usr/src/linux-${KV}
	    cp -ax ${S}/Documentation ${D}/usr/src/linux-${KV}
	       
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
	    
	    depmod -b ${D} -F ${S}/System.map ${KV}	
#	    rm -rf ${D}/lib/modules/`uname -r`
  	    #fix symlink
	    cd ${D}/lib/modules/${KV}
	    rm build
	    ln -sf /usr/src/linux-${KV} build
	fi

        if [ "`use alsa`" ]
        then
            #install ALSA modules
            cd ${KS}/extras/alsa-driver-${AV}
	    dodoc INSTALL FAQ
	    dodir /lib/modules/${KV}/misc
	    cp modules/*.o ${D}/lib/modules/${KV}/misc
        fi
	if [ "`use pcmcia-cs`" ]
	then
	    #install PCMCIA modules and utilities
	    cd ${KS}/extras/pcmcia-cs-${PCV}
	    try make PREFIX=${D} install  
	    rm -rf ${D}/etc/rc.d
	    exeinto /etc/rc.d/init.d
	    doexe ${FILESDIR}/${KV}/pcmcia
	fi	    

    else
	dodir /usr/src
    	
	cd ${S}
	make mrproper

	echo ">>> Copying sources..."
	cp -ax ${S} ${D}/usr/src
	
	#don't overwrite existing .config if present
	cd ${D}/usr/src/linux-${KV}
	if [ -e .config ]
	then
	    cp -a .config .config.eg
	fi
    fi
}

pkg_postinst() {
    rm -f ${ROOT}/usr/src/linux
    ln -sf linux-${KV} ${ROOT}/usr/src/linux
    
    #copy over our .config if one isn't already present
    cd ${ROOT}/usr/src/linux-${KV}
    if [ "${PN}" = "linux-sources" ] && [ -e .config.eg ] && [ ! -e .config ]
    then
	cp -a .config.eg .config
    fi
}

#pkg_postrm() {
#
#    rm -f ${ROOT}/usr/src/linux
#    rm -rf ${ROOT}/usr/src/linux-${KV}
#}
