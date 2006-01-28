# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Graph/PEAR-Image_Graph-0.7.1.ebuild,v 1.1 2006/01/28 07:22:35 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="A package for displaying (numerical) data as a graph/chart/plot."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-Image_Canvas
	dev-php/PEAR-Numbers_Roman
	dev-php/PEAR-Numbers_Words"
