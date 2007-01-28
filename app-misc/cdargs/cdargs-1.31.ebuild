# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdargs/cdargs-1.31.ebuild,v 1.5 2007/01/28 05:02:48 genone Exp $

DESCRIPTION="Bookmarks and browser for the shell builtin cd command"
HOMEPAGE="http://www.skamphausen.de/software/cdargs"
SRC_URI="http://www.skamphausen.de/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="emacs"

DEPEND="sys-libs/ncurses"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README INSTALL THANKS TODO AUTHORS COPYING

	cd ${S}/contrib
	insinto /usr/share/cdargs
	doins cdargs-bash.sh cdargs-tcsh.csh \
		|| die "failed to install contrib scripts"
	if use emacs ; then
		doins cdargs.el || die "failed to install cdargs.el"
	fi
}

pkg_postinst() {
	echo
	elog "Add the following line to your ~/.bashrc to enable cdargs helper"
	elog "functions/aliases in your environment:"
	elog "[ -f /usr/share/cdargs/cdargs-bash.sh ] && \\ "
	elog "		source /usr/share/cdargs/cdargs-bash.sh"
	elog
	elog "Users of tcshell will find cdargs-tcsh.csh there with a reduced"
	elog "feature set.  See INSTALL file in the documentation directory for"
	elog "more information."

	if use emacs ; then
		elog
		elog "To get an interactive cv defun in (X)Emacs load cdargs.el:"
		elog " (setq load-path"
		elog "       (append (list "
		elog "        \"/usr/share/cdargs/\")"
		elog "        load-path))"
		elog " (require 'cdargs)"
	fi
	echo
}
