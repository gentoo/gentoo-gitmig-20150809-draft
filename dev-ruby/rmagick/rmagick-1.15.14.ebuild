# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-1.15.14.ebuild,v 1.1 2008/05/09 05:36:41 graaff Exp $

inherit ruby

# The gem for this package doesn't seem to play well with portage.  It
# runs a GNUish configure script, with argument passed directly from
# the gem install command, but gem install doesn't use the same style
# of arguments.  Thus, unless you're smart enough to come up with a
# fix, please leave this as a source package install.

DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://rmagick.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/RMagick-${PV}.tar.bz2"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples doc"
DEPEND="virtual/ruby
	>=media-gfx/imagemagick-6.0"

S=${WORKDIR}/RMagick-${PV}

# hdri causes extensive changes in the imagemagick internals, and
# rmagick is not ready to deal with those, see bug 184356.
pkg_setup() {
	if built_with_use --missing false media-gfx/imagemagick hdri ; then
		eerror "imagemagick is built with the hdri USE flag, this is not supported by rmagick"
		eerror "please rebuild imagemagick without hdri support if you want to use rmagick"
		die "imagemagick is built with the hdri USE flag, this is not supported by rmagick"
	fi
}

# Using a custom src_compile instead of the ruby one because the ruby
# one gets confused by an additional setup.rb that should not be used
# here.
src_compile() {
	myconf="${RUBY_ECONF} ${EXTRA_ECONF}"

	# When documentation is built many examples are also run. Not all
	# of them may work (e.g. due to missing additional dependencies)
	# so we allow the examples to fail.
	if ! use doc ; then
		myconf="${myconf} --disable-htmldoc --enable-allow-example-errors"
	fi

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--with-ruby=${RUBY} \
		${myconf} \
		"$@" || die "econf failed"

	ruby_emake "$@" || die
}

# Use a custom src_install instead of the default one in ruby.eclass
# because the one in ruby.eclass does not include setting the prefix
# for the installation step.
src_install() {
	RUBY_ECONF="${RUBY_ECONF} ${EXTRA_ECONF}"

	${RUBY} setup.rb config --prefix="${D}/usr" "$@" \
		${RUBY_ECONF} || die "setup.rb config failed"
	${RUBY} setup.rb install --prefix="${D}" "$@" \
		${RUBY_ECONF} || die "setup.rb install failed"

	cd "${S}"
	dodoc ChangeLog README.html README-Mac-OSX.txt README.txt
}
