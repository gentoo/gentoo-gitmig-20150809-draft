# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.5.0.ebuild,v 1.1 2003/06/27 12:20:16 liquidx Exp $

S=${WORKDIR}/${PN}

IUSE="ssl sdl"

DESCRIPTION="Portable Multiplatform Class Libraries for OpenH323"
HOMEPAGE="http://www.openh323.org"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86 ~ppc -sparc"

DEPEND=">=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a
	dev-libs/expat
	>=sys-apps/sed-4
	ldap? ( net-nds/openldap )
	sdl? ( media-libs/libsdl )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd ${S}/make
    # filter out -O3 and -mcpu embedded compiler flags
	sed -e "s:-mcpu=\$(CPUTYPE)::" \
		-e "s:-O3 -DNDEBUG:-DNDEBUG:" \
		-i unix.mak

}

src_compile() {

	if [ "`use ssl`" ]; then
		export OPENSSLFLAG=1
       	export OPENSSLDIR=/usr
       	export OPENSSLLIBS="-lssl -lcrypt"
	fi

	#export PWLIBDIR=${S}

	econf
	emake opt || die "make failed"
}

src_install() {
	# make these because the makefile isn't smart enough
	dodir /usr/bin /usr/lib /usr/share /usr/include
	make PREFIX=${D}/usr install || die "install failed"

	# these are for compiling openh323
	# FIXME: probably should fix this with ptlib-config
	dodir /usr/share/pwlib/include
	dodir /usr/share/pwlib/lib
	for x in ptlib.h ptbuildopts.h ptlib ptclib; do
		dosym /usr/include/${x} /usr/share/pwlib/include/${x}
   	done
	for x in ${D}/usr/lib/*; do
		dosym /usr/lib/`basename ${x}` /usr/share/pwlib/lib/`basename ${x}`
	done

	# remove CVS dirs
	find ${D} -name CVS -type d | xargs rm -rf

	# fix symlink
   	rm ${D}/usr/lib/libpt.so
	if [ ${ARCH} = "ppc" ] ; then
		dosym /usr/lib/libpt_linux_ppc_r.so.${PV} /usr/lib/libpt.so
	else
		dosym /usr/lib/libpt_linux_x86_r.so.${PV} /usr/lib/libpt.so
	fi

	# strip ${S} stuff
	sed -i -e "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" ${D}/usr/bin/ptlib-config
	sed -i -e "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" ${D}/usr/share/pwlib/make/ptbuildopts.mak

	# strip out -L/usr/lib to allow upgrades
	sed -i -e "s:^\(LDFLAGS.*\)-L/usr/lib:\1:" ${D}/usr/share/pwlib/make/ptbuildopts.mak
	sed -i -e "s:^\(LDFLAGS[\s]*=.*\) -L/usr/lib:\1:" ${D}/usr/bin/ptlib-config

	dodoc ReadMe.txt History.txt
}
