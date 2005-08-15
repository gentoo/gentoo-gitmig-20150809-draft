# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.8.3-r1.ebuild,v 1.5 2005/08/15 19:43:02 stkn Exp $

inherit eutils flag-o-matic multilib

IUSE="ssl sdl ieee1394 alsa esd v4l2"

MY_P="${PN}-v${PV//./_}"
DESCRIPTION="Portable Multiplatform Class Libraries for OpenH323"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="mirror://sourceforge/openh323/${MY_P}-src-tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ppc amd64"

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

S=${WORKDIR}/${PN}

src_unpack() {
	# currently complaining to upstream about new naming scheme
	tar -C ${WORKDIR} -xzf ${DISTDIR}/${MY_P}-src-tar.gz || die "Unpacking of ${PF} failed"

	cd ${S}/make

	# filter out -O3 and -mcpu embedded compiler flags
	sed -i \
		-e "s:-mcpu=\$(CPUTYPE)::" \
		-e "s:-O3 -DNDEBUG:-DNDEBUG:" \
		unix.mak

	# newer esound package doesn't install libesd.a anymore,
	# use dynamic library instead (fixes #100432)
	epatch ${FILESDIR}/pwlib-1.6.3-dyn-esd.patch
}

src_compile() {
	local plugins
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
	myconf="${myconf} --enable-ipv6"

	# plugins, oss and v4l are default
	plugins="oss v4l"

	use ieee1394 \
		&& plugins="${plugins} avc dc"

	use alsa \
		&& plugins="${plugins} alsa"

	if use v4l2; then
		myconf="${myconf} --enable-v4l2"
		plugins="${plugins} v4l2"
	fi

	if use esd; then
		# fixes bug #45059
		export ESDDIR=/usr

		# ESD includes are in /usr/include?
		# remove include path, bad things may happen if we leave it in there
		sed -i -e "s:-I\$(ESDDIR)/include::" \
			${S}/make/unix.mak
	fi

	# merge plugin options (safe way if default = "")
	plugins="$(echo ${plugins} | sed -e "y: :,:")"

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

	emake -j1 opt || die "make failed"
}

src_install() {
	# makefile doesn't create ${D}/usr/bin
	dodir /usr/bin
	make PREFIX=/usr DESTDIR=${D} install || die "install failed"

	## vv will try to fix the mess below, requires a lot of patching though...

	# these are for compiling openh323
	# NOTE: symlinks don't work when upgrading
	# FIXME: probably should fix this with ptlib-config
	dodir /usr/share/pwlib/include
	cp -r ${D}/usr/include/* ${D}/usr/share/pwlib/include

	dodir /usr/share/pwlib/$(get_libdir)
	for x in ${D}/usr/$(get_libdir)/*; do
		dosym /usr/$(get_libdir)/`basename ${x}` /usr/share/pwlib/$(get_libdir)/`basename ${x}`
	done

	# just in case...
	if [[ "$(get_libdir)" = "lib64" ]]; then
		dosym /usr/share/pwlib/$(get_libdir) /usr/share/pwlib/lib
	fi

	## ^^ bad stuff

	# fix symlink
	# only amd64 needs special handling, afaics
	rm ${D}/usr/$(get_libdir)/libpt.so
	if use amd64; then
		dosym /usr/$(get_libdir)/libpt_linux_x86_64_r.so.${PV} /usr/$(get_libdir)/libpt.so
	else
		dosym /usr/$(get_libdir)/libpt_linux_${ARCH}_r.so.${PV} /usr/$(get_libdir)/libpt.so
	fi

	# strip ${S} stuff
	dosed "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" /usr/bin/ptlib-config
	dosed "s:^PWLIBDIR.*:PWLIBDIR=/usr/share/pwlib:" /usr/share/pwlib/make/ptbuildopts.mak

	# dodgy configure/makefiles forget to expand this
	dosed 's:${exec_prefix}:/usr:' /usr/bin/ptlib-config

	# copy version.h
	insinto /usr/share/pwlib
	doins version.h

	dodoc ReadMe.txt ReadMe_QOS.txt History.txt ChangeLog mpl-1.0.htm
}
