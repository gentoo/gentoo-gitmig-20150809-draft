# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.4.11.ebuild,v 1.5 2003/09/06 22:29:25 msterret Exp $

DESCRIPTION="Libs needed for GnomeMeeting"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc -sparc"
IUSE="ssl"

DEPEND=">=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a
	dev-libs/expat
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}/make

	# filter out -O3 and -mcpu embedded compiler flags
	sed -i \
		-e "s:-mcpu=\$(CPUTYPE)::" \
		-e "s:-O3 -DNDEBUG:-DNDEBUG:" \
		unix.mak

	# patch unix.mak so it doesn't require annoying upgrades
	sed -i \
		-e "s:-DP_SSL -I\$(OPENSSLDIR)/include -I\$(OPENSSLDIR)/crypto:-DP_SSL:" \
		-e "s:^LDFLAGS.*\+= -L\$(OPENSSLDIR)/lib -L\$(OPENSSLDIR):LDFLAGS +=:" \
		unix.mak
}

src_compile() {
	export PWLIBDIR=${S}
	export PWLIB_BUILD="yes"

	if [ "`use ssl`" ]; then
		export OPENSSLFLAG=1
        	export OPENSSLDIR=/usr
        	export OPENSSLLIBS="-lssl -lcrypt"
	fi

	make optshared || die

	cd tools/asnparser
	make optshared || die
}

src_install() {
	dodir /usr/lib /usr/include/ptlib/unix/ptlib \
		/usr/share/pwlib /usr/include/ptclib

	cd ${S}
	cp -a lib/*so* ${D}/usr/lib
	cp -a include/ptlib.h ${D}/usr/include
	cp -a include/ptlib/*.h ${D}/usr/include/ptlib/
	cp -a include/ptlib/*.inl ${D}/usr/include/ptlib/
	cp -a include/ptlib/unix/ptlib/*.h ${D}/usr/include/ptlib/unix/ptlib
	cp -a include/ptlib/unix/ptlib/*.inl ${D}/usr/include/ptlib/unix/ptlib
	cp -a include/ptclib/*.h ${D}/usr/include/ptclib/

	cp -a * ${D}/usr/share/pwlib/
	rm -rf ${D}/usr/share/pwlib/make/CVS
        rm -rf ${D}/usr/share/pwlib/tools/CVS
	rm -rf ${D}/usr/share/pwlib/tools/asnparser/CVS
	rm -rf ${D}/usr/share/pwlib/src
	rm -rf ${D}/usr/share/pwlib/include/CVS
	rm -rf ${D}/usr/share/pwlib/include/ptlib/unix/CVS
	rm -rf ${D}/usr/share/pwlib/include/ptlib/CVS

	cd ${D}/usr/lib
	if [ ${ARCH} = "ppc" ] ; then
		ln -sf libpt_linux_ppc_r.so.${PV} libpt.so
	else
		ln -sf libpt_linux_x86_r.so.${PV} libpt.so
	fi
}
