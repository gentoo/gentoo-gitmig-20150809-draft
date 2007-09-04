# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexftp/obexftp-0.22_rc6.ebuild,v 1.1 2007/09/04 14:45:33 mrness Exp $

WANT_AUTOMAKE="none"

inherit eutils perl-module flag-o-matic autotools

DESCRIPTION="File transfer over OBEX for mobile phones"
HOMEPAGE="http://dev.zuckschwerdt.org/openobex/wiki/ObexFtp"
SRC_URI="http://triq.net/obexftp/${P/_/-}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="bluetooth debug nls perl python swig tcl"

RDEPEND=">=dev-libs/openobex-1.3
	bluetooth? ( >=net-wireless/bluez-libs-2.25 )
	perl? ( >=dev-lang/perl-5.8.8 )
	python? ( >=dev-lang/python-2.4.4 )
	tcl? ( >=dev-lang/tcl-8.4.14 )
	swig? ( >=dev-lang/swig-1.3.31 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}"/${P%_*}

src_unpack() {
	unpack ${A}

	if ! use nls ; then
		cd "${S}"
		epatch "${FILESDIR}/${P%_*}-no_iconv.patch"
		eautoconf
	fi
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
