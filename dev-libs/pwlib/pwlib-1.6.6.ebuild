# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.6.6.ebuild,v 1.7 2004/10/23 13:58:20 weeve Exp $

inherit eutils

IUSE="ssl sdl ieee1394 alsa esd"

MY_P="${PN}-v${PV//./_}"
DESCRIPTION="Portable Multiplatform Class Libraries for OpenH323"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="mirror://sourceforge/openh323/${MY_P}-src.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND=">=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a
	dev-libs/expat
	>=sys-apps/sed-4
	net-nds/openldap
	sdl? ( media-libs/libsdl )
	ssl? ( dev-libs/openssl )
	alsa? ( media-libs/alsa-lib )
	ieee1394? ( media-libs/libdv
		sys-libs/libavc1394
		sys-libs/libraw1394
		media-plugins/libdc1394 )
	esd? ( media-sound/esound )"

MAKEOPTS="${MAKEOPTS} -j1"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}/make

	# filter out -O3 and -mcpu embedded compiler flags
	sed -i \
		-e "s:-mcpu=\$(CPUTYPE)::" \
		-e "s:-O3 -DNDEBUG:-DNDEBUG:" \
		unix.mak

	# small fix for firewire dc (camera) plugin
	cd ${S}
	epatch ${FILESDIR}/${P}-ieee1394dc-fix.diff
}

src_compile() {
	local plugins
	local myconf

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
	myconf="${myconf} --enable-ipv6"

	# plugins, oss and v4l are default
	plugins="oss v4l"

	use ieee1394 \
		&& plugins="${plugins} avc dc"

	use alsa \
		&& plugins="${plugins} alsa"

	if use esd; then
		# fixes bug #45059
		export ESDDIR=/usr
	fi

	# merge plugin options (safe way if default = "")
	plugins="`echo ${plugins} | sed -e "y: :,:"`"

	econf ${myconf} \
		--enable-plugins \
		--with-plugins=${plugins} || die "configure failed"

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

	# remove -fno-rtti, this breaks various things *grr*
	sed -i -e "s:-fno-rtti::" \
		make/ptbuildopts.mak
	sed -i -e "s:-fno-rtti::" \
		make/ptlib-config

	emake opt || die "make failed"
	emake PWLIBDIR=${S} -C plugins opt || die "make plugins failed"
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
	# only amd64 needs special handling, afaiks
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
