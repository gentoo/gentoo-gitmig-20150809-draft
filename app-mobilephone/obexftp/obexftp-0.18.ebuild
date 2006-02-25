# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexftp/obexftp-0.18.ebuild,v 1.5 2006/02/25 15:20:12 mrness Exp $

inherit perl-module

DESCRIPTION="File transfer over OBEX for mobile phones"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"
HOMEPAGE="http://triq.net/obex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE="bluetooth debug perl python tcltk"

DEPEND="=dev-libs/openobex-1.0*
	bluetooth? ( >=net-wireless/bluez-libs-2.19 )
	perl? ( >=dev-lang/perl-5.8.6 )
	python? ( >=dev-lang/python-2.4.2 )
	tcltk? ( >=dev-lang/tcl-8.4.9 )"

src_compile() {
	if use debug ; then
		strip-flags
		append-flags "-g -DOBEXFTP_DEBUG=5"
	fi

	econf \
		$(use_enable bluetooth) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcltk tcl) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO
	dohtml doc/*.html
	insinto /usr/share/doc/${PF}/examples
	doins -r apps/*_example.*
	use perl && fixlocalpod
}
