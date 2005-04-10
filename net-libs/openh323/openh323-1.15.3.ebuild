# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.15.3.ebuild,v 1.1 2005/04/10 22:06:02 stkn Exp $

IUSE="ssl novideo noaudio debug"

inherit eutils flag-o-matic multilib

MY_P="${PN}-v${PV//./_}"

S=${WORKDIR}/${P}
DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.gnomemeeting.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86 ~sparc ~alpha ~ppc ~amd64"

DEPEND=">=sys-apps/sed-4
	>=dev-libs/pwlib-1.8.4
	>=media-video/ffmpeg-0.4.7
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Makefile is currently broken with NOTRACE=1, fix that
	epatch ${FILESDIR}/${PN}-1.15.2-notrace.diff
}

src_compile() {
	local makeopts
	local myconf

	# remove -fstack-protector, may cause problems (bug #75259)
	filter-flags -fstack-protector

	export PWLIBDIR=/usr/share/pwlib
	export PTLIB_CONFIG=/usr/bin/ptlib-config
	export OPENH323DIR=${S}

	makeopts="${makeopts} ASNPARSER=/usr/bin/asnparser LDFLAGS=-L${S}/lib"

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
	local makeopts
	# make NOTRACE=1 opt ==> linux_$ARCH_n
	# make opt           ==> linux_$ARCH_r
	if ! use debug; then
		OPENH323_SUFFIX="n"
		makeopts="NOTRACE=1"
	else
		OPENH323_SUFFIX="r"
	fi

	# amd64 needs special treatment
	if use amd64; then
		OPENH323_ARCH="linux_x86_64_${OPENH323_SUFFIX}"
	else
		OPENH323_ARCH="linux_${ARCH}_${OPENH323_SUFFIX}"
	fi

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

	# workaround: don't install libh323*.so and libh323.so.${PV}
	if [[ -f ${D}/usr/$(get_libdir)/libh323_${OPENH323_ARCH}.so ]]; then
		# libh323*.so is a file... replace it w/ a symlink
		rm -f ${D}/usr/$(get_libdir)/libh323_${OPENH323_ARCH}.so

		dosym  /usr/$(get_libdir)/libh323_${OPENH323_ARCH}.so.${PV} \
			/usr/$(get_libdir)/libh323_${OPENH323_ARCH}.so
	fi

	###
	# Compatibility "hacks"
	#

	# mod to keep gnugk happy
	insinto /usr/share/openh323/src
	newins ${FILESDIR}/openh323-1.11.7-emptyMakefile Makefile

	# install version.h into $OPENH323DIR
	insinto /usr/share/openh323
	doins version.h

	rm ${D}/usr/$(get_libdir)/libopenh323.so
	dosym /usr/$(get_libdir)/libh323_${OPENH323_ARCH}.so.${PV} /usr/$(get_libdir)/libopenh323.so

	# for backwards compatibility with _r versioned libraries
	for pv in ${PV} ${PV%.[0-9]} ${PV%.[0-9]*.[0-9]}; do
		einfo "creating /usr/$(get_libdir)/libh323_${ALT_ARCH}.so.${pv} symlink"
		dosym /usr/$(get_libdir)/libh323_${OPENH323_ARCH}.so.${PV} /usr/$(get_libdir)/libh323_${ALT_ARCH}.so.${pv}
	done
	dosym /usr/$(get_libdir)/libh323_${OPENH323_ARCH}.so.${PV} /usr/$(get_libdir)/libh323_${ALT_ARCH}.so

	# these should point to the right directories,
	# openh323.org apps and others need this
	dosed "s:^OH323_LIBDIR = \$(OPENH323DIR).*:OH323_LIBDIR = /usr/$(get_libdir):" \
		/usr/share/openh323/openh323u.mak
	dosed "s:^OH323_INCDIR = \$(OPENH323DIR).*:OH323_INCDIR = /usr/include/openh323:" \
		/usr/share/openh323/openh323u.mak
	# this is hardcoded now?
	dosed "s:^\(OPENH323DIR[ \t]\+=\) ${S}:\1 /usr/share/openh323:" \
		/usr/share/openh323/openh323u.mak
}
