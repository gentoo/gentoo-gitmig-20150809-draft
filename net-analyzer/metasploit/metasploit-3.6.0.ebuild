# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-3.6.0.ebuild,v 1.1 2011/04/18 09:26:10 patrick Exp $

SRC_URI="http://updates.metasploit.com/data/releases/framework-${PV}.tar.bz2"

DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"

LICENSE="BSD"
SLOT="3.6"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gtk sqlite postgres"

# Note we use bundled gems (see data/msfweb/vendor/rails/) as upstream voted for
# such solution, bug #247787
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	gtk? ( dev-ruby/ruby-libglade2 )
	sqlite? ( dev-ruby/sqlite3-ruby
		 dev-ruby/activerecord )
	postgres? ( dev-ruby/ruby-postgres
		dev-ruby/activerecord )"
DEPEND=""

S=${WORKDIR}/msf3

src_install() {
	if [[ "${SRC_URI}" != "" ]] ; then
		# svn sources...
		find "${S}" -type d -name ".svn" -print0 | xargs -0 -n1 rm -R
	fi

	# should be as simple as copying everything into the target...
	dodir /usr/lib/${PN}${SLOT}
	cp -R "${S}"/* "${D}"/usr/lib/${PN}${SLOT} || die "Copy files failed"

	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF}
	cp -R "${S}"/{documentation,README} "${D}"/usr/share/doc/${PF}
	rm -Rf "${D}"/usr/lib/${PN}${SLOT}/documentation "${D}"/usr/lib/${PN}${SLOT}/README
	dosym /usr/share/doc/${PF}/documentation /usr/lib/${PN}${SLOT}/documentation

	dodir /usr/bin/
	use gtk || rm msfgui
	for file in msf*; do
		dosym /usr/lib/${PN}${SLOT}/${file} /usr/bin/${file}${SLOT}
	done

	chown -R root:0 "${D}"

}

pkg_postinst() {
	if [[ "${SRC_URI}" == "" ]] ; then
		elog "If you wish to update ${PN} manually simply run:"
		elog
		elog "ESVN_REVISION=<rev> emerge =${PF}"
		elog
		elog "where <rev> is either HEAD (in case you wish to get all updates)"
		elog "or specific revision number. But NOTE, this update will vanish"
		elog "next time you reemerge ${PN}. To make update permanent either"
		elog "create ebuild with specific revision number inside your overlay"
		elog "or report revision bump bug at http://bugs.gentoo.org ."
		elog
		elog "In case you use portage it's also possible to create"
		elog "/etc/portage/env/${CATEGORY}/${PN} file with ESVN_REVISION=<rev>"
		elog "content. Then each time you run emerge ${PN} you'll have said"
		elog "<rev> installed. For example, if you run"
		elog " # mkdir -p /etc/portage/env/${CATEGORY}"
		elog " # echo ESVN_REVISION=HEAD >> /etc/portage/env/${CATEGORY}/${PN}"
		elog "each time you reemerge ${PN} it'll be updated to get all possible"
		elog "updates for framework-${PV%_p*} branch."
		elog "You can do similar things in paludis using /etc/paludis/bashrc."
	fi
}
