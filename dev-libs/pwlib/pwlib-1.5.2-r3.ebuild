# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.5.2-r3.ebuild,v 1.5 2004/03/30 22:25:15 stkn Exp $

DESCRIPTION="Portable Multiplatform Class Libraries for OpenH323"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha amd64"
IUSE="ssl sdl ldap"

DEPEND=">=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a
	dev-libs/expat
	>=sys-apps/sed-4
	ldap? ( net-nds/openldap )
	sdl? ( media-libs/libsdl )
	ssl? ( dev-libs/openssl )"

MAKEOPTS="${MAKEOPTS} -j1"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix #45846 / CAN-2004-0097
	epatch ${FILESDIR}/${P}-asnparser-secfix.diff

	cd ${S}/make

	# filter out -O3 and -mcpu embedded compiler flags
	sed -i \
		-e "s:-mcpu=\$(CPUTYPE)::" \
		-e "s:-O3 -DNDEBUG:-DNDEBUG:" \
		unix.mak
}

src_compile() {
	if [ "`use ssl`" ]; then
		export OPENSSLFLAG=1
		export OPENSSLDIR="/usr"
		export OPENSSLLIBS="-lssl -lcrypt"
	fi

	econf || die "configure failed"

	# Horrible hack to strip out -L/usr/lib to allow upgrades
	# problem is it adds -L/usr/lib before -L${S} when SSL is
	# enabled.  Same thing for -I/usr/include.
	sed -i -e "s:^\(LDFLAGS.*\)-L/usr/lib:\1:" \
		-e "s:^\(STDCCFLAGS.*\)-I/usr/include:\1:" \
		${S}/make/ptbuildopts.mak
	sed -i -e "s:^\(LDFLAGS[\s]*=.*\) -L/usr/lib:\1:" \
		-e "s:^\(LDFLAGS[\s]*=.*\) -I/usr/include:\1:" \
		-e "s:^\(CCFLAGS[\s]*=.*\) -I/usr/include:\1:" \
		${S}/make/ptlib-config

	emake opt || die "make failed"
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
	# only amd64 needs special care, afaiks
	rm ${D}/usr/lib/libpt.so
	if [ ${ARCH} = "amd64" ] ; then
		dosym /usr/lib/libpt_linux_x86_64_r.so.${PV} /usr/lib/libpt.so
	else
		dosym /usr/lib/libpt_linux_${ARCH}_r.so.${PV} /usr/lib/libpt.so
	fi

	# strip ${S} stuff
	dosed "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" /usr/bin/ptlib-config
	dosed "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" /usr/share/pwlib/make/ptbuildopts.mak

	# dodgy configure/makefiles forget to expand this
	dosed 's:${exec_prefix}:/usr:' /usr/bin/ptlib-config

	# satisfy ptlib.mak's weird definition (should check if true for future versions)
	cp ${D}/usr/bin/ptlib-config ${D}/usr/share/pwlib/make/ptlib-config

	# copy version.h
	insinto /usr/share/pwlib
	doins version.h

	dodoc ReadMe.txt History.txt
}
