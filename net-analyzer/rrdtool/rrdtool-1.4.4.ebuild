# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.4.4.ebuild,v 1.1 2010/12/16 07:12:54 graaff Exp $

EAPI="3"

GENTOO_DEPEND_ON_PERL="no"
inherit eutils flag-o-matic multilib perl-module autotools

DESCRIPTION="A system to store and display time-series data"
HOMEPAGE="http://oss.oetiker.ch/rrdtool/"
SRC_URI="http://oss.oetiker.ch/rrdtool/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-solaris"
IUSE="doc lua perl python ruby rrdcgi tcl"

# This versions are minimal versions upstream tested with.
RDEPEND="
	>=media-libs/libpng-1.2.10
	>=dev-libs/libxml2-2.6.31
	>=x11-libs/cairo-1.4.6[svg]
	>=dev-libs/glib-2.12.12
	>=x11-libs/pango-1.17
	lua? ( dev-lang/lua )
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	ruby? ( >=dev-lang/ruby-1.8.6_p287-r13 !dev-ruby/ruby-rrd )
	tcl? ( dev-lang/tcl )"

DEPEND="${RDEPEND}
	sys-apps/gawk"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.3.8-configure.ac.patch"
	epatch "${FILESDIR}/${PN}-1.4.3-ruby-ldflags.patch"
	epatch "${FILESDIR}/${P}-dont-link-system-lib.patch"
	sed -i '/PERLLD/s:same as PERLCC:same-as-PERLCC:' configure.ac #281694
	eautoreconf
}

src_configure() {
	filter-flags -ffast-math

	export RRDDOCDIR=${EPREFIX}/usr/share/doc/${PF}

	# to solve bug #260380
	[[ ${CHOST} == *-solaris* ]] && append-flags -D__EXTENSIONS__

	econf $(use_enable rrdcgi) \
		$(use_enable lua) \
		$(use_enable lua lua-site-install) \
		$(use_enable ruby) \
		$(use_enable ruby ruby-site-install) \
		$(use_enable perl) \
		$(use_enable perl perl-site-install) \
		--with-perl-options=INSTALLDIRS=vendor \
		$(use_enable tcl) \
		$(use_with tcl tcllib "${EPREFIX}"/usr/$(get_libdir)) \
		$(use_enable python)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if ! use doc ; then
		rm -rf "${ED}"usr/share/doc/${PF}/{html,txt}
	fi

	if use !rrdcgi ; then
		# uses rrdcgi, causes invalid shebang error in Prefix, useless
		# without rrdcgi installed
		rm -f "${ED}"usr/share/${PN}/examples/cgi-demo.cgi
	fi

	if use perl ; then
		perl_delete_localpod
		perl_delete_packlist
	fi

	dodoc CHANGES CONTRIBUTORS NEWS README THREADS TODO
}

pkg_postinst() {
	ewarn "rrdtool dump 1.3 does emit completely legal xml. Basically this means that"
	ewarn "it contains an xml header and a DOCTYPE definition. Unfortunately this"
	ewarn "causes older versions of rrdtool restore to be unhappy."
	ewarn
	ewarn "To restore a new dump with an old rrdtool restore version, either remove"
	ewarn "the xml header and the doctype by hand (both on the first line of the dump)"
	ewarn "or use rrdtool dump --no-header."
	ewarn
	ewarn "Note: rrdtool-1.3.x doesn't have any default font bundled. Thus if you've"
	ewarn "upgraded from rrdtool-1.2.x and don't have any font installed to make"
	ewarn "lables visible, please, install some font, e.g. media-fonts/dejavu."
}
