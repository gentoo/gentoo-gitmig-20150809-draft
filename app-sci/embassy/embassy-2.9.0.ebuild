# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/embassy/embassy-2.9.0.ebuild,v 1.1 2004/07/20 02:55:39 ribosome Exp $

DESCRIPTION="A meta-package for installing all EMBASSY packages (EMBOSS add-ons)"
HOMEPAGE="http://www.emboss.org/"
SRC_URI=""
LICENSE="GPL-2 freedist"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

# IUSE="no-conflict"
# In the future, I plan to integrate packages such as the standalone meme, which
# would conflict with the corresponding embassy-meme package. Conflicting
# EMBASSY packages will be marked as blockers of the standalone version (and vice
# versa), and the no-conflict USE flag will make it easy to install all EMBASSY
# packages except the conflictual ones.

RDEPEND="=app-sci/embassy-domainatrix
	=app-sci/embassy-emnu
	=app-sci/embassy-esim4
	=app-sci/embassy-hmmer
	=app-sci/embassy-meme
	=app-sci/embassy-mse
	=app-sci/embassy-phylip
	=app-sci/embassy-topo"
