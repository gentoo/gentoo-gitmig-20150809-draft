# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.8.7.ebuild,v 1.2 2006/05/01 17:48:11 halcy0n Exp $

inherit eutils flag-o-matic multilib

IUSE="alsa esd ieee1394 oss sdl ssl v4l2"

DESCRIPTION="Portable Multiplatform Class Libraries for OpenH323"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.gnomemeeting.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

RDEPEND="
	dev-libs/expat
	net-nds/openldap
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )
	ssl? ( dev-libs/openssl )
	alsa? ( media-libs/alsa-lib )
	ieee1394? ( media-libs/libdv
		sys-libs/libavc1394
		sys-libs/libraw1394
		<media-libs/libdc1394-1.9.9
		!>=media-libs/libdc1394-2.0.0_pre0 )"

DEPEND="${REDEPEND}
	>=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	# filter out -O3 and -mcpu embedded compiler flags
	sed -i \
		-e "s:-mcpu=\$(CPUTYPE)::" \
		-e "s:-O3 -DNDEBUG:-DNDEBUG:" \
		make/unix.mak

	# newer esound package doesn't install libesd.a anymore,
	# use dynamic library instead (fixes #100432)
	epatch ${FILESDIR}/pwlib-1.6.3-dyn-esd.patch

	# don't break make install if there are no plugins to install
	epatch ${FILESDIR}/pwlib-1.8.7-instplugins.diff

	# gcc-4 patch
	epatch ${FILESDIR}/pwlib-1.8.4-gcc4.diff
	epatch "${FILESDIR}"/${P}-gcc41.patch

}

src_compile() {
	local myconf

	# may cause ICE (bug #70638)
	filter-flags -fstack-protector

	if use ssl; then
		export OPENSSLFLAG=1
		export OPENSSLDIR="/usr"
		export OPENSSLLIBS="-lssl -lcrypt"
	fi

	## gnomemeeting-1.00 requires pwlib to be built w/ IPV6 support
	## (even if itself is built without...)
	#use ipv6 \
	#	&& myconf="${myconf} --enable-ipv6" \
	#	|| myconf="${myconf} --disable-ipv6"

	# enable default plugins and force ipv6
	myconf="--enable-ipv6 --enable-v4l"

	use ieee1394 \
		&& myconf="${myconf} --enable-avc --enable-dc" \
		|| myconf="${myconf} --disable-avc --disable-dc"

	use alsa \
		&& myconf="${myconf} --enable-alsa"

	if use esd; then
		# fixes bug #45059
		export ESDDIR=/usr

		# ESD includes are in /usr/include?
		# remove include path, bad things may happen if we leave it in there
		sed -i -e "s:-I\$(ESDDIR)/include::" \
			${S}/make/unix.mak
	fi

	econf \
		--enable-plugins \
		$(use_enable v4l2) \
		$(use_enable sdl) \
		$(use_enable oss) \
		${myconf} || die "configure failed"

	# Horrible hack to strip out -L/usr/lib to allow upgrades
	# problem is it adds -L/usr/lib before -L${S} when SSL is
	# enabled.  Same thing for -I/usr/include.
	sed -i  -e "s:^\(LDFLAGS.*\)-L/usr/lib:\1:" \
		-e "s:^\(STDCCFLAGS.*\)-I/usr/include:\1:" \
		${S}/make/ptbuildopts.mak

	sed -i  -e "s:^\(LDFLAGS[\s]*=.*\) -L/usr/lib:\1:" \
		-e "s:^\(LDFLAGS[\s]*=.*\) -I/usr/include:\1:" \
		-e "s:^\(CCFLAGS[\s]*=.*\) -I/usr/include:\1:" \
		${S}/make/ptlib-config

	emake -j1 opt || die "make failed"
}

src_install() {
	local libdir libname

	libdir=$(get_libdir)

	# makefile doesn't create ${D}/usr/bin
	dodir /usr/bin
	make PREFIX=/usr DESTDIR=${D} install || die "install failed"

	# fix symlink
	rm ${D}/usr/${libdir}/libpt.so

	libname=$(basename `ls ${D}/usr/${libdir}/libpt_*_*_r.so.${PV}`)
	dosym /usr/${libdir}/${libname} /usr/${libdir}/libpt.so

	# strip ${S} stuff
	sed -i -e "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" \
		${D}/usr/bin/ptlib-config \
		${D}/usr/share/pwlib/make/ptlib-config \
		${D}/usr/share/pwlib/make/ptbuildopts.mak

	# fix makefiles to use headers from /usr/include and libs from /usr/lib
	# instead of /usr/share/pwlib
	sed -i  -e "s:-I\$(PWLIBDIR)\(/include[a-zA-Z0-9_/-]\+\):-I/usr/include\1:g" \
		-e "s:-I\$(PWLIBDIR)/include::g" \
		-e "s:^\(PW_LIBDIR[ \t]\+=\).*:\1 /usr/${libdir}:" \
		${D}/usr/share/pwlib/make/*.mak

	# dodgy configure/makefiles forget to expand this
	sed -i -e "s:\${exec_prefix}:/usr:" \
		${D}/usr/bin/ptlib-config \
		${D}/usr/share/pwlib/make/ptlib-config

	# copy version.h
	insinto /usr/share/pwlib
	doins version.h

	dodoc ReadMe.txt ReadMe_QOS.txt History.txt mpl-1.0.htm
}
