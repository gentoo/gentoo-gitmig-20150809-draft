# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/df-mode/df-mode-1.5.ebuild,v 1.1 2007/12/14 08:03:58 ulm Exp $

inherit elisp

DESCRIPTION="Displays space left on a device in the mode line"
HOMEPAGE="http://groups.google.com/groups?selm=ye4ww2cbiry.fsf%40alpha4.bocal.cs.univ-paris8.fr"
SRC_URI="mirror://gentoo/df-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

SITEFILE=50df-gentoo.el
S="${WORKDIR}/df-${PV}"
