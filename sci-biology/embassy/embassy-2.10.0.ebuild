# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy/embassy-2.10.0.ebuild,v 1.1 2005/03/25 01:43:31 ribosome Exp $

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

RDEPEND="!=sci-biology/emboss-2.9*
	=sci-biology/emboss-2.10*
	=sci-biology/embassy-construct-1.0.0
	=sci-biology/embassy-esim4-1.0.0-r1
	=sci-biology/embassy-hmmer-2.1.1-r1
	=sci-biology/embassy-meme-2.3.1-r1
	=sci-biology/embassy-mse-1.0.0-r1
	=sci-biology/embassy-phylip-3.57c-r1
	=sci-biology/embassy-topo-1.0.0-r1"
