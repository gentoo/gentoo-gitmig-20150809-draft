# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.5.0-r1.ebuild,v 1.1 2004/02/09 01:20:43 nerdboy Exp $

DESCRIPTION="Portable Multiplatform Class Libraries for OpenH323"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc"
IUSE="ssl sdl"

DEPEND=">=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a
	dev-libs/expat
	>=sys-apps/sed-4
	ldap? ( net-nds/openldap )
	sdl? ( media-libs/libsdl )
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
	cd ${S}
	epatch ${FILESDIR}/pwlib-1.5.0-r1-gentoo.patch || die "patch failed"
}

src_compile() {
	if [ "`use ssl`" ]; then
		export OPENSSLFLAG=1
		export OPENSSLDIR=/usr
		export OPENSSLLIBS="-lssl -lcrypt"
	fi

	econf || die "configure failed"

	# horrible hack to strip out -L/usr/lib to allow upgrades
	# problem is it adds -L/usr/lib before -L${S} when SSL is enabled
	sed -i -e "s:^\(LDFLAGS.*\)-L/usr/lib:\1:" ${S}/make/ptbuildopts.mak
	sed -i -e "s:^\(LDFLAGS[\s]*=.*\) -L/usr/lib:\1:" ${S}/make/ptlib-config

	make opt || die "make failed"
}

src_install() {
	# make these because the makefile isn't smart enough
	dodir /usr/bin /usr/lib /usr/share /usr/include
	make PREFIX=${D}/usr install || die "install failed"

	# these are for compiling openh323
	# NOTE: symlinks don't work when upgrading
	# FIXME: probably should fix this with ptlib-config
	dodir /usr/share/pwlib/include
	cp -r ${D}/usr/include/* ${D}/usr/share/pwlib/include

	dodir /usr/share/pwlib/lib
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
	dosed "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" /usr/bin/ptlib-config
	dosed "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" /usr/share/pwlib/make/ptbuildopts.mak

	dodoc ReadMe.txt History.txt
}
