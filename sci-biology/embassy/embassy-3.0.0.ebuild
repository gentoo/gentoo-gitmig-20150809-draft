# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy/embassy-3.0.0.ebuild,v 1.1 2005/08/07 21:41:10 ribosome Exp $

DESCRIPTION="A meta-package for installing all EMBASSY packages (EMBOSS add-ons)"
HOMEPAGE="http://www.emboss.org/"
SRC_URI=""
LICENSE="GPL-2 freedist"

SLOT="0"
KEYWORDS="~ppc ~ppc-macos ~x86"
IUSE=""

# IUSE="no-conflict"
# In the future, I plan to integrate packages such as the standalone meme, which
# would conflict with the corresponding embassy-meme package. Conflicting
# EMBASSY packages will be marked as blockers of the standalone version (and vice
# versa), and the no-conflict USE flag will make it easy to install all EMBASSY
# packages except the conflictual ones.

RDEPEND="!<sci-biology/emboss-3.0.0
	!sci-biology/embassy-construct
	=sci-biology/emboss-3.0.0*
	=sci-biology/embassy-domainatrix-0.1.0
	=sci-biology/embassy-domalign-0.1.0
	=sci-biology/embassy-domsearch-0.1.0
	=sci-biology/embassy-signature-0.1.0
	=sci-biology/embassy-structure-0.1.0
	=sci-biology/embassy-emnu-1.05-r2
	=sci-biology/embassy-esim4-1.0.0-r2
	=sci-biology/embassy-hmmer-2.1.1-r2
	=sci-biology/embassy-meme-2.3.1-r2
	=sci-biology/embassy-mse-1.0.0-r2
	=sci-biology/embassy-phylip-3.6b
	=sci-biology/embassy-topo-1.0.0-r2"
