# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.15.6.ebuild,v 1.2 2006/05/01 18:06:17 halcy0n Exp $

inherit eutils flag-o-matic multilib

MY_P="${PN}-v${PV//./_}"

DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.gnomemeeting.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

IUSE="ssl novideo noaudio debug"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

RDEPEND="
	~dev-libs/pwlib-1.8.7
	>=media-video/ffmpeg-0.4.7
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Makefile is currently broken with NOTRACE=1, fix that
	epatch "${FILESDIR}"/${PN}-1.15.2-notrace.diff
	epatch "${FILESDIR}"/${P}-gcc4.diff
}

src_compile() {
	local makeopts
	local myconf

	# remove -fstack-protector, may cause problems (bug #75259)
	filter-flags -fstack-protector

	export PWLIBDIR=/usr/share/pwlib
	export PTLIB_CONFIG=/usr/bin/ptlib-config
	export OPENH323DIR=${S}

	makeopts="ASNPARSER=/usr/bin/asnparser LDFLAGS=-L${S}/lib"

	# NOTRACE avoid compilation problems, we disable PTRACING using NOTRACE=1
	# compile with PTRACING if the user wants to debug stuff
	if ! use debug; then
		makeopts="${makeopts} NOTRACE=1"
	fi

	if use ssl; then
		export OPENSSLFLAG=1
		export OPENSSLDIR=/usr
		export OPENSSLLIBS="-lssl -lcrypt"
	fi

	use novideo \
		&& myconf="${myconf} --disable-video"

	use noaudio \
		&& myconf="${myconf} --disable-audio"

	econf ${myconf} || die "configure failed"
	emake ${makeopts} opt || die "make failed"
}

src_install() {
	local OPENH323_ARCH ALT_ARCH OPENH323_SUFFIX
	local makeopts libdir

	# make NOTRACE=1 opt ==> linux_$ARCH_n
	# make opt           ==> linux_$ARCH_r
	if ! use debug; then
		OPENH323_SUFFIX="n"
		makeopts="NOTRACE=1"
	else
		OPENH323_SUFFIX="r"
	fi

	# use ptlib-config to get the right values here (for hppa, amd64 ...)
	OPENH323_ARCH="$(ptlib-config --ostype)_$(ptlib-config --machtype)_${OPENH323_SUFFIX}"

	# set ALT_ARCH
	if use debug; then
		ALT_ARCH=${OPENH323_ARCH/_r/_n}
	else
		ALT_ARCH=${OPENH323_ARCH/_n/_r}
	fi

	###
	# Install stuff
	#
	make PREFIX=/usr DESTDIR=${D} \
		OH323_FILE="libh323_${OPENH323_ARCH}.so.${PV}" \
		${makeopts} install || die "install failed"

	libdir=$(get_libdir)

	# fix openh323's bogus symlinks
	for pv in ${PV%.[0-9]} ${PV%.[0-9]*.[0-9]}; do
		rm -f ${D}/usr/${libdir}/libh323_${OPENH323_ARCH}.so.${pv}

		dosym /usr/${libdir}/libh323_${OPENH323_ARCH}.so.${PV} \
			/usr/${libdir}/libh323_${OPENH323_ARCH}.so.${pv}
	done
	rm -f ${D}/usr/${libdir}/libh323_${OPENH323_ARCH}.so
	dosym /usr/${libdir}/libh323_${OPENH323_ARCH}.so.${PV} \
		/usr/${libdir}/libh323_${OPENH323_ARCH}.so

	# create backwards compatibility with _r versioned libraries
	for pv in ${PV} ${PV%.[0-9]} ${PV%.[0-9]*.[0-9]}; do
		# compat symlink
		dosym /usr/${libdir}/libh323_${OPENH323_ARCH}.so.${PV} \
			/usr/${libdir}/libh323_${ALT_ARCH}.so.${pv}
	done
	dosym /usr/${libdir}/libh323_${OPENH323_ARCH}.so.${PV} \
		/usr/${libdir}/libh323_${ALT_ARCH}.so

	###
	# Compatibility "hacks"
	#

	# mod to keep gnugk happy (still needed?)
	insinto /usr/share/openh323/src
	newins ${FILESDIR}/openh323-1.11.7-emptyMakefile Makefile

	# install version.h into $OPENH323DIR
	insinto /usr/share/openh323
	doins version.h

	# should try to get rid of this one
	rm -f ${D}/usr/${libdir}/libopenh323.so
	dosym /usr/${libdir}/libh323_${OPENH323_ARCH}.so.${PV} /usr/${libdir}/libopenh323.so

	# these should point to the right directories,
	# openh323.org apps and others need this
	dosed "s:^OH323_LIBDIR = \$(OPENH323DIR).*:OH323_LIBDIR = /usr/${libdir}:" \
		/usr/share/openh323/openh323u.mak
	dosed "s:^OH323_INCDIR = \$(OPENH323DIR).*:OH323_INCDIR = /usr/include/openh323:" \
		/usr/share/openh323/openh323u.mak

	# this is hardcoded now?
	dosed "s:^\(OPENH323DIR[ \t]\+=\) ${S}:\1 /usr/share/openh323:" \
		/usr/share/openh323/openh323u.mak
}
