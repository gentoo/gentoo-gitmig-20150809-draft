# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmime/gmime-2.2.26.ebuild,v 1.6 2010/07/11 19:01:33 armin76 Exp $

inherit gnome2 eutils mono libtool autotools

DESCRIPTION="Utilities for creating and parsing messages using MIME"
#SRC_URI="http://spruce.sourceforge.net/${PN}/sources/v${PV%.*}/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/gmime/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="doc mono"

RDEPEND=">=dev-libs/glib-2
	sys-libs/zlib
	mono? (
		dev-lang/mono
		>=dev-dotnet/gtk-sharp-2.4.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gtk-doc-am
	doc? (
		>=dev-util/gtk-doc-1.0
		app-text/docbook-sgml-utils )
	mono? ( dev-dotnet/gtk-sharp-gapi )"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS PORTING README TODO doc/html/"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/gmime-2.2.23-sign-assembly.patch"

	# Fix Buffer overflow by calculating the maximum number of output bytes generated
	# by an uuencode operation, bug 308051
	epatch "${FILESDIR}/gmime-2.2.26-uuencode-buffer-overflow.patch"

	cp "${FILESDIR}/gmime-sharp.snk" mono/
	if use doc ; then
		#db2html should be docbook2html
		sed -i -e 's:db2html:docbook2html -o gmime-tut:g' \
			docs/tutorial/Makefile.am docs/tutorial/Makefile.in \
			|| die "sed failed (1)"
		# Fix doc targets (bug #97154)
		sed -i -e 's!\<\(tmpl-build.stamp\): !\1 $(srcdir)/tmpl/*.sgml: !' \
			gtk-doc.make docs/reference/Makefile.in || die "sed failed (3)"
	fi

	eautoreconf
	elibtoolize
}

src_compile() {
	econf $(use_enable mono) $(use_enable doc gtk-doc)
	MONO_PATH="${S}" emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"

	if use doc ; then
		# we don't use docinto/dodoc, because we don't want html doc gzipped
		insinto /usr/share/doc/${PF}/tutorial
		doins docs/tutorial/html/*
	fi

	# rename these two, so they don't conflict with app-arch/sharutils
	# (bug #70392)	Ticho, 2004-11-10
	mv "${D}/usr/bin/uuencode" "${D}/usr/bin/gmime-uuencode"
	mv "${D}/usr/bin/uudecode" "${D}/usr/bin/gmime-uudecode"
	mono_multilib_comply
}
