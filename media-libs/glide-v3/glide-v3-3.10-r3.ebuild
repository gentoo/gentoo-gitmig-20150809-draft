# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glide-v3/glide-v3-3.10-r3.ebuild,v 1.12 2004/01/21 06:07:48 vapier Exp $

# NOTE:  Do NOT build this with optimizations, as it will make this package
#        unstable!!!!

S=${WORKDIR}/${PN/-v3/3x}
DESCRIPTION="Hardware support for the voodoo3, voodoo4 and voodoo5"
HOMEPAGE="http://glide.sourceforge.net/"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/glide3x-${PV}.tar.gz
	http://www.ibiblio.org/gentoo/distfiles/swlibs-${PV}.tar.gz"
# check for future updates here
# http://telia.dl.sourceforge.net/mirrors/slackware/slackware-8.0/contrib/contrib-sources/3dfx/voodoo4_voodoo5/

LICENSE="3DFX"
SLOT="0"
KEYWORDS="x86 sparc alpha"
IUSE="voodoo3"

DEPEND=">=sys-devel/automake-1.4
	>=sys-devel/autoconf-2.13
	>=sys-devel/libtool-1.3.3
	>=sys-devel/m4-1.4
	>=dev-lang/perl-5.005"
PROVIDE="virtual/glide"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	chmod +x swlibs/include/make/ostype
	cd ${S} ; ln -fs ${WORKDIR}/swlibs swlibs
	cd ${S}/h3/minihwc ; ln -fs linhwc.c.dri linhwc.c
	cd ${S}/h3/glide3/src ; ln -fs gglide.c.dri gglide.c
	ln -fs gsst.c.dri gsst.c ; ln -fs glfb.c.dri glfb.c

	cd ${S}
	libtoolize -f && aclocal && automake && autoconf
}

src_compile() {
	local compilefor=
	use voodoo3 \
		&& compilefor="h3" \
		|| compilefor="h5"
	mkdir build
	cd build
	../configure \
		--prefix=/usr \
		--enable-fx-glide-hw=${compilefor} \
		--enable-fx-dri-build \
		|| die

	# On alpha at least, glide incorrectly guesses 486 processor.
	# Fixup the makefiles.
	if use alpha; then
		find . -type f | xargs grep -le -m486 | \
			xargs sed -i -e "s|-m486|${CFLAGS}|"
	fi

	./build.3dfx all || die
}

src_install() {
	cd ${S}/build
	./build.3dfx DESTDIR=${D} install || die

	dodir /usr/X11R6/lib
	dosym /usr/lib/libglide3.so.${PV}.0 /usr/X11R6/lib/libglide3.so
}
