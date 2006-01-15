# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nanoblogger/nanoblogger-3.2.3.ebuild,v 1.3 2006/01/15 17:22:48 hansmi Exp $

inherit bash-completion

DESCRIPTION="Small and simple weblog engine written in Bash for the command-line"
HOMEPAGE="http://nanoblogger.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ppc ~x86"
IUSE=""

RDEPEND="app-shells/bash"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's|^\(NB_BASE_DIR=\).*$|\1"/usr/share/nanoblogger"|' \
		-e 's|"$NB_BASE_DIR/\(nb\.conf\)"|"/etc/\1"|g' \
		-e "s|\$NB_BASE_DIR.*\(nano.*html\)|/usr/share/doc/${PF}/html/\1|" \
			nb || die "sed nb failed"
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
	einfo "Documentation for getting started with nanoblogger may be found at"
	einfo "/usr/share/doc/${PF}/html/nanoblogger.html or by running 'nb --manual;."
	einfo
	einfo "To create and configure a new weblog, run the following as your user:"
	einfo "   nb -b /some/dir -a"
	einfo "where /some/dir is a directory that DOES NOT exist."
	einfo
	einfo "To prevent having to specify your blog directory every time you use"
	einfo "nanoblogger (with the -b switch), you can set a default value in your"
	einfo "~/.nb.conf.  For example:"
	einfo '   BLOG_DIR="$HOME/public_html/blog"'
	einfo
	einfo "If you are upgrading nanoblogger from a previous version, follow"
	einfo "these directions (as stated in the manual):"
	einfo "    1. create a new weblog directory using nanoblogger (skip configuration):"
	einfo "      nb [-b blog_dir] -a"
	einfo "    2. copy old data directry to new weblog:"
	einfo "      cp -r [old_blog_dir]/data [newblog_dir]"
	einfo "    3. edit new blog.conf to your liking and rebuild weblog:"
	einfo "      nb [-b blog_dir] --configure -u all"
	echo
	bash-completion_pkg_postinst
}
