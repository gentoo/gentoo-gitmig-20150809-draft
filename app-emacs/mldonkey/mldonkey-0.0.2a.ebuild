# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mldonkey/mldonkey-0.0.2a.ebuild,v 1.3 2004/06/24 22:18:34 agriffis Exp $

inherit elisp

DESCRIPTION="mldonkey.el is an  Emacs Lisp application which and allows you to monitor your downloads and control the MLDonkey core from within your GNU Emacs."
HOMEPAGE="http://www.physik.fu-berlin.de/~dhansen/mldonkey/"
SRC_URI="http://www.physik.fu-berlin.de/~dhansen/mldonkey/mldonkey-el-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/

SITEFILE=50mldonkey-gentoo.el
