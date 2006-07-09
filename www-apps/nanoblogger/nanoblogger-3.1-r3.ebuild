# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nanoblogger/nanoblogger-3.1-r3.ebuild,v 1.6 2006/07/09 21:02:08 rl03 Exp $

inherit bash-completion eutils

DESCRIPTION="Small and simple weblog engine written in Bash for the command-line"
HOMEPAGE="http://nanoblogger.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 x86"
IUSE=""

RDEPEND="app-shells/bash"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's|^\(BASE_DIR=\).*$|\1"/usr/share/nanoblogger"|' \
		-e 's|"$BASE_DIR"/\(nb\.conf\)|/etc/\1|' \
		-e "s|\$BASE_DIR.*\(nano.*html\)|/usr/share/doc/${PF}/html/\1|" \
			nb || die "sed nb failed"
	epatch ${FILESDIR}/${P}-fix-rss2.diff
}

src_install() {
	dobin nb
	insinto /usr/share/nanoblogger
	doins -r default moods plugins
	insinto /etc
	doins nb.conf
	dodoc ChangeLog
	dohtml docs/nanoblogger.html
	dobashcompletion ${FILESDIR}/nb.bashcomp
}

pkg_postinst() {
	echo
	elog "Documentation for getting started with nanoblogger may be found at"
	elog "/usr/share/doc/${PF}/html/nanoblogger.html or by running 'nb --manual;."
	elog
	elog "To create and configure a new weblog, run the following as your user:"
	elog "   nb -b /some/dir -a"
	elog "where /some/dir is a directory that DOES NOT exist."
	elog
	elog "To prevent having to specify your blog directory every time you use"
	elog "nanoblogger (with the -b switch), you can set a default value in your"
	elog "~/.nb.conf.  For example:"
	elog '   BLOG_DIR="$HOME/public_html/blog"'
	bash-completion_pkg_postinst
}
