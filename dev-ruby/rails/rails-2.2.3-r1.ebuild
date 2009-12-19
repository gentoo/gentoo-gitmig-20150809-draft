# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rails/rails-2.2.3-r1.ebuild,v 1.5 2009/12/19 14:24:48 jer Exp $

inherit ruby gems
USE_RUBY="ruby18"

DESCRIPTION="ruby on rails is a web-application and persistance framework"
HOMEPAGE="http://www.rubyonrails.org"

LICENSE="MIT"
SLOT="2.2"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="fastcgi"
DEPEND=">=dev-lang/ruby-1.8.5
	>=app-admin/eselect-rails-0.14
	>=dev-ruby/rake-0.8.3
	~dev-ruby/activerecord-2.2.3
	~dev-ruby/activeresource-2.2.3
	~dev-ruby/activesupport-2.2.3
	~dev-ruby/actionmailer-2.2.3
	=dev-ruby/actionpack-2.2.3-r1"

RDEPEND="${DEPEND}
	fastcgi? ( >=dev-ruby/ruby-fcgi-0.8.6 )
	>=dev-ruby/rubygems-1.3.1"

src_install() {
	gems_src_install
	# Rename slotted files that may clash so that eselect can handle
	# them
	mv "${D}/usr/bin/rails" "${D}/usr/bin/rails-${PV}"
	sed -i -e "s/>= 0/${PV}/" "${D}/usr/bin/rails-${PV}"
	mv "${D}/${GEMSDIR}/bin/rails" "${D}/${GEMSDIR}/bin/rails-${PV}"
}

pkg_postinst() {
	einfo "To select between slots of rails, use:"
	einfo "\teselect rails"

	eselect rails update
}

pkg_postrm() {
	eselect rails update
}
