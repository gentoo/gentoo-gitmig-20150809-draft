# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-oci8/ruby-oci8-0.1.15.ebuild,v 1.4 2006/08/21 09:51:44 mattm Exp $

inherit ruby

DESCRIPTION="A Ruby extension library to use Oracle"
HOMEPAGE="http://rubyforge.org/projects/ruby-oci8/"
SRC_URI="http://rubyforge.org/frs/download.php/10081/ruby-oci8-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

USE_RUBY="ruby18 ruby19"

RDEPEND="dev-db/oracle-instantclient-basic
	dev-db/oracle-instantclient-sqlplus"
DEPEND="virtual/ruby ${RDEPEND}"

src_compile() {
	emake -j1 CONFIG_OPT="--prefix=${D}usr" || die
}

src_install() {
	make DESTDIR=${D} install || die

}
