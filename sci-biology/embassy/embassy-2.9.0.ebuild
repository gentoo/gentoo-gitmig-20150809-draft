# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy/embassy-2.9.0.ebuild,v 1.4 2005/03/23 23:08:07 ribosome Exp $

DESCRIPTION="A meta-package for installing all EMBASSY packages (EMBOSS add-ons)"
HOMEPAGE="http://www.emboss.org/"
SRC_URI=""
LICENSE="GPL-2 freedist"

SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos"
IUSE=""

# IUSE="no-conflict"
# In the future, I plan to integrate packages such as the standalone meme, which
# would conflict with the corresponding embassy-meme package. Conflicting
# EMBASSY packages will be marked as blockers of the standalone version (and vice
# versa), and the no-conflict USE flag will make it easy to install all EMBASSY
# packages except the conflictual ones.

RDEPEND="!=sci-biology/emboss-2.10*
	sci-biology/embassy-domainatrix
	sci-biology/embassy-emnu
	sci-biology/embassy-esim4
	sci-biology/embassy-hmmer
	sci-biology/embassy-meme
	sci-biology/embassy-mse
	sci-biology/embassy-phylip
	sci-biology/embassy-topo"
