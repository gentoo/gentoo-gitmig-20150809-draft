# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/yate/yate-1.3.0.ebuild,v 1.2 2009/02/06 15:21:30 drizzt Exp $

IUSE="doc gsm gtk h323 ilbc postgres zaptel"

inherit eutils autotools

DESCRIPTION="YATE - Yet Another Telephony Engine"
HOMEPAGE="http://yate.null.ro/"
SRC_URI="http://yate.null.ro/tarballs/yate1/${P}-1.tar.gz"

S="${WORKDIR}"/${PN}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=media-libs/speex-1.2_beta2
	media-sound/sox
	zaptel? ( >=net-libs/libpri-1.0.0
	          >=net-misc/zaptel-1.0.0 )
	h323? ( >=net-libs/openh323-1.15.3 )
	gtk? ( >=x11-libs/gtk+-2.6.8 )
	gsm? ( media-sound/gsm )
	doc? ( >=dev-util/kdoc-2.0_alpha54 )
	postgres? ( virtual/postgresql-server )"

RDEPEND=$DEPEND

RESTRICT="test"		# Test does not lauch unit tests

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix makefiles for custom CFLAGS/LDFLAGS
	epatch "${FILESDIR}"/${P}-makefiles.patch
	epatch "${FILESDIR}"/${P}-resolv.patch #199222

	eautoconf
}

src_compile() {
	econf \
		$(use_with gtk libgtk2) \
		$(use_with h323 openh323 /usr) \
		$(use_with h323 pwlib /usr) \
		$(use_with zaptel libpri) \
		$(use_with gsm libgsm) \
		$(use_with postgres libpq /usr) \
		$(use_enable ilbc) \
		|| die "Configure failed"

	emake all contrib test || die "Building failed"

	if use doc; then
		emake apidocs || die "Building of API docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install-noapi || die "emake install failed"

	newinitd "${FILESDIR}/yate.rc6" yate
	newconfd "${FILESDIR}/yate.confd" yate

	# install standard docs...
	dodoc README ChangeLog docs/*.html

	# install api docs
	if use doc; then
		docinto api
		dodoc docs/api/*.html
	fi

	docinto scripts
	dodoc scripts/*
}
