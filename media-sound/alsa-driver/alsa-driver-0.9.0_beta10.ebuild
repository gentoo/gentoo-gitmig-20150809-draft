# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org> 
# /space/gentoo/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-0.5.12a.  ebuild,v 1.2 2002/01/02 22:00:27 woodchip Exp

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set ALSA_CARDS
# environment variable accordingly
[ x${ALSA_CARDS} = x ] && ALSA_CARDS=all

#transform P to match tarball versioning
MYPV=${PV/_beta/beta}
MYP="${PN}-${MYPV}"
KV=""

S=${WORKDIR}/${MYP}

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"

SRC_URI="ftp://ftp.alsa-project.org/pub/driver/${MYP}.tar.bz2"

HOMEPAGE="http://www.alsa-project.org"

#virtual/glibc should depend on specific kernel headers
DEPEND="sys-devel/autoconf virtual/glibc"
PROVIDE="virtual/alsa"

pkg_setup() {
	KV=`readlink /usr/src/linux`
	if [ $? -ne 0 ] ; then
		echo 
		echo "/usr/src/linux symlink does not exist; cannot continue."
		echo
		die
	else
		#alsa-driver will compile modules for the kernel pointed to by /usr/src/linux
		KV=${KV/linux-/}
	fi
}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-kernel="${ROOT}usr/src/linux-${KV}" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-oss=yes \
		--with-cards=${ALSA_CARDS} \
		|| die "./configure failed"
	
	emake || die "Parallel Make Failed"

}

src_install () {
	
	insinto /usr/include/sound
	cd ${S}/include
	doins *.h
	cd ${S}
	dodoc CARDS-STATUS COPYING FAQ INSTALL README WARNING TODO
	dodir /lib/modules/${KV}/misc
	cp ${S}/modules/*.o ${D}/lib/modules/${KV}/misc
	insinto /etc/modules.d
	doins ${FILESDIR}/alsa
	insinto /etc/init.d
	doins ${S}/utils/alsasound

}

pkg_postinst () {
	/usr/sbin/update-modules || return 0
}
