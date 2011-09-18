# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/barby/barby-0.5.0.ebuild,v 1.1 2011/09/18 13:40:41 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="site"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="Ruby barcode generator that doesn't rely on 3rd party libraries."
HOMEPAGE="http://toretore.eu/barby/"

GITHUB_USER="toretore"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${P}.tgz"
RUBY_S="${GITHUB_USER}-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test datamatrix pdf-writer qrcode rmagick prawn png cairo"

USE_RUBY="ruby18 ree18" \
	ruby_add_rdepend "
		datamatrix? ( dev-ruby/semacode )
		pdf-writer? ( dev-ruby/pdf-writer )"

# ruby19 as well, if it worked
USE_RUBY="ruby18 ree18" \
	ruby_add_rdepend "
		rmagick? ( dev-ruby/rmagick )
		cairo? ( dev-ruby/rcairo )"

USE_RUBY="ruby18 ree18 jruby" \
	ruby_add_rdepend "prawn? ( dev-ruby/prawn )"

ruby_add_rdepend "qrcode? ( dev-ruby/rqrcode )
	png? ( dev-ruby/chunky_png )"

ruby_add_bdepend "test? ( dev-ruby/minitest )"

# prawn breaks tests for some reasons, needs to be investigated; code
# still works though.
RESTRICT="prawn? ( test )"

all_ruby_prepare() {
	sed -i -e '/[bB]undler/s:^:#:' test/test_helper.rb
}

each_ruby_prepare() {
	if ! use datamatrix; then
		rm \
			lib/barby/barcode/data_matrix.rb \
			test/data_matrix_test.rb
	fi

	if ! use pdf-writer; then
		rm \
			lib/barby/outputter/pdfwriter_outputter.rb \
			test/outputter/pdfwriter_outputter_test.rb
	fi

	if ! use qrcode; then
		rm \
			lib/barby/barcode/qr_code.rb \
			test/qr_code_test.rb
	fi

	if ! use rmagick; then
		rm \
			lib/barby/outputter/rmagick_outputter.rb \
			test/outputter/rmagick_outputter_test.rb
	fi

	if ! use prawn; then
		rm \
			lib/barby/outputter/prawn_outputter.rb \
			test/outputter/prawn_outputter_test.rb
	fi

	if ! use png; then
		rm \
			lib/barby/outputter/png_outputter.rb \
			test/outputter/png_outputter_test.rb
	fi

	if ! use cairo; then
		rm \
			lib/barby/outputter/cairo_outputter.rb \
			test/outputter/cairo_outputter_test.rb
	fi

	case ${RUBY} in
		*/ruby19)
			rm -f \
				lib/barby/barcode/data_matrix.rb \
				test/data_matrix_test.rb \
				lib/barby/outputter/pdfwriter_outputter.rb \
				test/outputter/pdfwriter_outputter_test.rb \
				lib/barby/outputter/prawn_outputter.rb \
				test/outputter/prawn_outputter_test.rb
			;;
		*/jruby)
			rm -f \
				lib/barby/barcode/data_matrix.rb \
				test/data_matrix_test.rb \
				lib/barby/outputter/pdfwriter_outputter.rb \
				test/outputter/pdfwriter_outputter_test.rb \
				lib/barby/outputter/rmagick_outputter.rb \
				test/outputter/rmagick_outputter_test.rb \
				lib/barby/outputter/cairo_outputter.rb \
				test/outputter/cairo_outputter_test.rb
			;;
	esac
}
