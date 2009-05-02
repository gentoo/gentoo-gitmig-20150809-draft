# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexftp/obexftp-0.22.ebuild,v 1.11 2009/05/02 08:12:42 mrness Exp $

EAPI="2"

inherit eutils perl-module flag-o-matic python

DESCRIPTION="File transfer over OBEX for mobile phones"
HOMEPAGE="http://dev.zuckschwerdt.org/openobex/wiki/ObexFtp"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="bluetooth debug perl python ruby swig tcl"

RDEPEND="dev-libs/openobex
	bluetooth? ( net-wireless/bluez-libs )
	perl? ( dev-lang/perl )
	python? ( >=dev-lang/python-2.4.4 )
	ruby? ( dev-lang/ruby:1.8 )
	tcl? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	swig? ( dev-lang/swig )
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ruby-libpath.patch
	epatch "${FILESDIR}"/${P}-bluetooth.patch
}

src_configure() {
	# do not byte-compile python module
	if use python; then
		sed -i \
			-e 's/\(setup.py install\)/\1 --no-compile/' \
			swig/python/Makefile.in || die "sed failed"
	fi

	if use debug ; then
		strip-flags
		append-flags "-g -DOBEXFTP_DEBUG=5"
	fi

	local MYRUBY
	use ruby && MYRUBY="RUBY=/usr/bin/ruby18"

	econf \
		$(use_enable bluetooth) \
		$(use_enable swig) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcl) \
		$(use_enable ruby) \
		${MYRUBY} || die "econf failed"
}

src_install() {
	# -j1 because "make -fMakefile.ruby install" fails
	# upstream added -j1 to that command so it should be removed
	# from here in the next version bump
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO
	dohtml doc/*.html

	# Install examples
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.c
	use perl && doins examples/*.pl
	use python && doins examples/*.py
	use ruby && doins examples/*.rb
	use tcl && doins examples/*.tcl

	use perl && fixlocalpod
}

pkg_postrm() {
	use perl && perl-module_pkg_postrm
	use python && python_mod_cleanup
}

pkg_postinst() {
	use perl && perl-module_pkg_postinst
	use python && {
		python_version
		python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	}
}
