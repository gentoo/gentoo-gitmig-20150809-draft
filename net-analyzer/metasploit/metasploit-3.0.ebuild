# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-3.0.ebuild,v 1.1 2007/09/09 11:56:20 cedk Exp $

inherit eutils

MY_P="${PN/metasploit/framework}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="The Metasploit Framework is an advanced open-source platform for developing, testing, and using vulnerability exploit code."
HOMEPAGE="http://www.metasploit.org/"
SRC_URI="${MY_P}.tar.gz"

LICENSE="MSF-1.2"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~x86"
RESTRICT="fetch"
IUSE="gtk sqlite sqlite3 postgres httpd"

RDEPEND="dev-lang/ruby
	gtk? ( dev-ruby/ruby-libglade2 )
	httpd? ( =dev-ruby/rails-1.2.2* )
	sqlite? ( dev-ruby/sqlite-ruby
		dev-ruby/activerecord )
	sqlite3? ( dev-ruby/sqlite3-ruby
		 dev-ruby/activerecord )
	postgres? ( dev-ruby/ruby-postgres
		dev-ruby/activerecord )"
DEPEND=""

pkg_nofetch() {
	# Fetch restricted due to license acceptation
	einfo "Please download the framework from:"
	einfo "http://metasploit.com/projects/Framework/msf3/download.html?Release=${MY_P}.tar.gz"
	einfo "and move it to ${DISTDIR}"
}

src_compile() {
	epatch "${FILESDIR}"/${P}.patch
}

src_install() {
	dodir /usr/lib/
	dodir /usr/bin/

	# remove the subversion directories
	find ${S} -type d -name ".svn" | xargs rm -R

	# should be as simple as copying everything into the target...
	dodir /usr/lib/metasploit${SLOT}
	cp -R "${S}"/* "${D}"/usr/lib/metasploit${SLOT} || die "Copy files failed"
	rm -Rf "${D}"/usr/lib/metasploit${SLOT}/documentation "${D}"/README

	for file in `ls msf*`; do
		dosym /usr/lib/metasploit${SLOT}/${file} /usr/bin/${file}${SLOT}
	done

	chown -R root:root ${D}

	if use httpd; then
		newinitd "${FILESDIR}"/msfweb${SLOT}.initd msfweb${SLOT} \
			|| die "newinitd failed"
		newconfd "${FILESDIR}"/msfweb${SLOT}.confd msfweb${SLOT} \
			|| die "newconfd failed"
	fi
}
