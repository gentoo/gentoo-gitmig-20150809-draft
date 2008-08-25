# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexftp/obexftp-0.21.ebuild,v 1.18 2008/08/25 17:28:39 nixnut Exp $

WANT_AUTOMAKE="1.9"

inherit eutils perl-module flag-o-matic autotools

DESCRIPTION="File transfer over OBEX for mobile phones"
SRC_URI="http://triq.net/obexftp/${P}.tar.bz2"
HOMEPAGE="http://triq.net/obex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="bluetooth debug nls perl python swig tcl"

RDEPEND="dev-libs/openobex
	bluetooth? ( net-wireless/bluez-libs )
	perl? ( dev-lang/perl )
	python? ( >=dev-lang/python-2.4.2 )
	tcl? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	swig? ( dev-lang/swig )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-cobex_write.patch"
	epatch "${FILESDIR}/${P}-sdp-detection.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	use nls || epatch "${FILESDIR}/${P}-no_iconv.patch"

	cd "${S}"
	eautoreconf
}

src_compile() {
	if use python || use tcl ; then
		# These wrappers break strict aliasing rules
		append-flags -fno-strict-aliasing
	fi
	if use debug ; then
		strip-flags
		append-flags "-g -DOBEXFTP_DEBUG=5"
	fi

	econf \
		$(use_enable bluetooth) \
		$(use_enable swig) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcl) \
		--disable-ruby || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO
	dohtml doc/*.html
	insinto /usr/share/doc/${PF}/examples
	doins -r apps/*_example.*
	use perl && fixlocalpod
}
