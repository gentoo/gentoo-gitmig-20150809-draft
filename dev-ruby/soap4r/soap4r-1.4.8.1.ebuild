# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/soap4r/soap4r-1.4.8.1.ebuild,v 1.2 2003/04/24 10:23:13 vapier Exp $

MY_PV=${PV//./_}
MY_P=${PN}-${MY_PV}
DESCRIPTION="an implementation of SOAP 1.1"
HOMEPAGE="http://rrr.jin.gr.jp/rwiki?cmd=view;name=soap4r"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/contrib/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ruby-1.8
	>=dev-ruby/devel-logger-1.0.1
	>=dev-ruby/http-access2-0j
	>=dev-ruby/rexml-2.5.3
	>=dev-ruby/uconv-0.4.10"

S=${WORKDIR}/${MY_P}

src_install() {
	cp install.rb install.rb.orig
	sed -e "s:^DSTPATH = :DSTPATH = \"${D}\" + \"/\" + :" install.rb.orig > install.rb
	ruby install.rb || die
}
