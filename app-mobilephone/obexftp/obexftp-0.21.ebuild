# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexftp/obexftp-0.21.ebuild,v 1.13 2007/06/23 14:06:36 angelos Exp $

WANT_AUTOMAKE="1.9"

inherit eutils perl-module flag-o-matic autotools

DESCRIPTION="File transfer over OBEX for mobile phones"
SRC_URI="http://triq.net/obexftp/${P}.tar.bz2"
HOMEPAGE="http://triq.net/obex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="bluetooth debug nls perl python swig tcl"

RDEPEND=">=dev-libs/openobex-1.1
	bluetooth? ( >=net-wireless/bluez-libs-2.19 )
	perl? ( >=dev-lang/perl-5.8.6 )
	python? ( >=dev-lang/python-2.4.2 )
	tcl? ( >=dev-lang/tcl-8.4.9 )
	swig? ( >=dev-lang/swig-1.3.7 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
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
