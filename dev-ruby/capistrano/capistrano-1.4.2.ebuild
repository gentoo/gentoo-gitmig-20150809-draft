# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/capistrano/capistrano-1.4.2.ebuild,v 1.6 2008/06/23 19:03:12 armin76 Exp $

inherit gems

DESCRIPTION="A distributed application deployment system"
HOMEPAGE="http://rubyforge.org/projects/capistrano/"

LICENSE="MIT"
SLOT="1"
KEYWORDS="amd64 ia64 ppc ppc64 x86"
IUSE=""

DEPEND=" >=dev-ruby/rake-0.7.0
	>=dev-ruby/net-ssh-1.0.10
	>=dev-ruby/net-sftp-1.1.0"
PDEPEND="dev-ruby/capistrano-launcher"

src_install() {
	gems_src_install

	# Deleted cap, as it will be provided by capistrano-launcher
	rm "${D}/usr/bin/cap"
	rm "${D}/${GEMSDIR}/bin/cap"
}
