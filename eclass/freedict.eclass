# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/freedict.eclass,v 1.4 2003/07/22 00:32:08 msterret Exp $

# Author: Seemant Kulleen <seemant@gentoo.org>
# This eclass exists to ease the installation of freedict translation
# dictionaries.  The only variables which need to be defined in the actual
# ebuilds are FORLANG and TOLANG for the source and target languages,
# respectively.

ECLASS="freedict"
INHERITED="$INHERITED $ECLASS"

IUSE=""

MY_P=${PN/freedict-/}

S=${WORKDIR}
DESCRIPTION="Freedict for language translation from ${FORLANG} to ${TOLANG}"
HOMEPAGE="http://www.freedict.de"
SRC_URI="http://freedict.sourceforge.net/download/linux/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

newdepend "app-text/dictd"

freedict_src_install() {
	insinto /usr/lib/dict
	doins ${MY_P}.dict.dz
	doins ${MY_P}.index
}

EXPORT_FUNCTIONS src_install
