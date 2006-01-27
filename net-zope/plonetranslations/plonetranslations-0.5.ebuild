# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plonetranslations/plonetranslations-0.5.ebuild,v 1.5 2006/01/27 02:43:17 vapier Exp $

inherit zproduct

DESCRIPTION="This product contains the .po files for CMFPlone. PlacelessTranslationService reads the files and enables multilinguality"
HOMEPAGE="http://www.sourceforge.net/projects/plone-i18n/"
SRC_URI="mirror://sourceforge/plone-i18n/PloneTranslations-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~amd64 ppc ~sparc x86"

ZPROD_LIST="PloneTranslations"
