# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.12.2.ebuild,v 1.1 2003/09/03 10:26:10 liquidx Exp $

IUSE="ssl"

S=${WORKDIR}/${PN}
DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"
HOMEPAGE="http://www.openh323.org"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86 ~ppc -sparc "

DEPEND=">=sys-apps/sed-4
	>=dev-libs/pwlib-1.5.0
	>=media-video/ffmpeg-0.4.7_pre20030624
	ssl? ( dev-libs/openssl )"

MAKEOPTS="${MAKEOPTS} -j1"

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
}

src_unpack() {
	unpack ${A}
	# enabling ffmpeg/h263 support
	cd ${S}; sed -i -e "s:/usr/local/include/ffmpeg:/usr/include/ffmpeg:" configure
}

src_compile() {
	local makeopts

	export PWLIBDIR=/usr/share/pwlib
	export PTLIB_CONFIG=/usr/bin/ptlib-config
	export OPENH323DIR=${S}

	# NOTRACE avoid compilation problems, we disable PTRACING using NOTRACE=1
	makeopts="${makeopts} ASNPARSER=/usr/bin/asnparser NOTRACE=1"

	
	if [ "`use ssl`" ]; then
		export OPENSSLFLAG=1
		export OPENSSLDIR=/usr
		export OPENSSLLIBS="-lssl -lcrypt"
	fi
	
	econf || die
	emake ${makeopts} opt || die "make failed"
}

src_install() {
	local OPENH323_ARCH ALT_ARCH
	# make NOTRACE=1 opt ==> linux_$ARCH_n
	# make opt           ==> linux_$ARCH_r
	OPENH323_ARCH="linux_${ARCH}_n"
	
	dodir /usr/bin /usr/lib/ /usr/share
	make PREFIX=${D}/usr install || die "install failed"
	dobin ${S}/samples/simple/obj_${OPENH323_ARCH}/simph323

	find ${D} -name 'CVS' -type d | xargs rm -rf

	# mod to keep gnugk happy
	insinto /usr/share/openh323/src
	newins ${FILESDIR}/openh323-1.11.7-emptyMakefile Makefile

	rm ${D}/usr/lib/libopenh323.so
	dosym /usr/lib/libh323_${OPENH323_ARCH}.so.${PV} /usr/lib/libopenh323.so
	
	# for backwards compatibility with _r versioned libraries
	ALT_ARCH=${OPENH323_ARCH/_n/_r}
	for pv in ${PV} ${PV%.[0-9]} ${PV%.[0-9]*.[0-9]}; do
		einfo "creating /usr/lib/libh323_${ALT_ARCH}.so.${pv} symlink"
		dosym /usr/lib/libh323_${OPENH323_ARCH}.so.${PV} /usr/lib/libh323_${ALT_ARCH}.so.${pv}
	done
	dosym /usr/lib/libh323_${OPENH323_ARCH}.so.${PV} /usr/lib/libh323_${ALT_ARCH}.so
	
}


