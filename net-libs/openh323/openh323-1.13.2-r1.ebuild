# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.13.2-r1.ebuild,v 1.16 2004/11/30 22:30:40 stkn Exp $

inherit eutils flag-o-matic

S=${WORKDIR}/${PN}
DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.gnomemeeting.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE="ssl"

DEPEND=">=sys-apps/sed-4
	~dev-libs/pwlib-1.6.3
	>=media-video/ffmpeg-0.4.7
	ssl? ( dev-libs/openssl )"

pkg_setup() {
	# to prevent merge problems with broken makefiles from old
	# pwlib versions, we double-check here.

	if [ "` fgrep '\$(OPENSSLDIR)/include' /usr/share/pwlib/make/unix.mak`" ]
	then
		# patch unix.mak so it doesn't require annoying
		# unmerge/merge cycle to upgrade
		einfo "Fixing broken pwlib makefile."
		cd /usr/share/pwlib/make
		sed -i \
		-e "s:-DP_SSL -I\$(OPENSSLDIR)/include -I\$(OPENSSLDIR)/crypto:-DP_SSL:" \
		-e "s:^LDFLAGS.*\+= -L\$(OPENSSLDIR)/lib -L\$(OPENSSLDIR):LDFLAGS +=:" \
		unix.mak
	fi

	if has_version ">=sys-devel/gcc-3.3.2"; then
		ewarn "If you are experiencing problems emerging openh323 with gcc-3.3.2"
		ewarn "please try using CFLAGS=\"-O1\" when emergeing"
		ewarn "we are currently investigating this problem..."
		ewarn ""
		ewarn "<sleeping 10 seconds...>"
		epause 10
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# fix and enable ffmpeg/h263 support (bug #32754)
	epatch ${FILESDIR}/openh323-${PV}-ffmpeg.diff

	# fix include order (bug #32522)
	epatch ${FILESDIR}/openh323-${PV}-include-order.diff

	# fix to compile on gcc-3.4 (bug #56951)
	epatch ${FILESDIR}/${P}-gcc34.diff

	# fix for 2.6 headers (bug #72448)
	epatch ${FILESDIR}/${P}-ixjuser.diff
}

src_compile() {
	local makeopts

	export PWLIBDIR=/usr/share/pwlib
	export PTLIB_CONFIG=/usr/bin/ptlib-config
	export OPENH323DIR=${S}

	# NOTRACE avoid compilation problems, we disable PTRACING using NOTRACE=1
	makeopts="${makeopts} ASNPARSER=/usr/bin/asnparser LDFLAGS=-L${S}/lib NOTRACE=1"

	if use ssl; then
		export OPENSSLFLAG=1
		export OPENSSLDIR=/usr
		export OPENSSLLIBS="-lssl -lcrypt"
	fi

	# use shipped speex version
	econf \
		--enable-localspeex || die

	use amd64 && append-flags -fPIC

	emake -j1 ${makeopts} opt || die "make failed"
}

src_install() {
	local OPENH323_ARCH ALT_ARCH
	# make NOTRACE=1 opt ==> linux_$ARCH_n
	# make opt           ==> linux_$ARCH_r

	# amd64 needs special treatment
	if [ ${ARCH} = "amd64" ]; then
		OPENH323_ARCH="linux_x86_64_n"
	else
		OPENH323_ARCH="linux_${ARCH}_n"
	fi

	dodir /usr/bin /usr/lib/ /usr/share
	make PREFIX=${D}/usr install || die "install failed"
	dobin ${S}/samples/simple/obj_${OPENH323_ARCH}/simph323

	# remove CVS stuff
	find ${D} -name 'CVS' -type d | xargs rm -rf

	# mod to keep gnugk happy
	insinto /usr/share/openh323/src
	newins ${FILESDIR}/openh323-1.11.7-emptyMakefile Makefile

	# install version.h into $OPENH323DIR
	insinto /usr/share/openh323
	doins version.h

	rm ${D}/usr/lib/libopenh323.so
	dosym /usr/lib/libh323_${OPENH323_ARCH}.so.${PV} /usr/lib/libopenh323.so

	# for backwards compatibility with _r versioned libraries
	# (this might not work...)
	ALT_ARCH=${OPENH323_ARCH/_n/_r}
	for pv in ${PV} ${PV%.[0-9]} ${PV%.[0-9]*.[0-9]}; do
		einfo "creating /usr/lib/libh323_${ALT_ARCH}.so.${pv} symlink"
		dosym /usr/lib/libh323_${OPENH323_ARCH}.so.${PV} /usr/lib/libh323_${ALT_ARCH}.so.${pv}
	done
	dosym /usr/lib/libh323_${OPENH323_ARCH}.so.${PV} /usr/lib/libh323_${ALT_ARCH}.so

	# these should point to the right directories,
	# openh323.org apps and others need this
	dosed "s:^OH323_LIBDIR = \$(OPENH323DIR).*:OH323_LIBDIR = /usr/lib:" \
		/usr/share/openh323/openh323u.mak
	dosed "s:^OH323_INCDIR = \$(OPENH323DIR).*:OH323_INCDIR = /usr/include/openh323:" \
		/usr/share/openh323/openh323u.mak
	# this is hardcoded now? nice...
	dosed "s:^\(OPENH323DIR[ \t]\+=\) ${S}:\1 /usr/share/openh323:" \
		/usr/share/openh323/openh323u.mak
}
