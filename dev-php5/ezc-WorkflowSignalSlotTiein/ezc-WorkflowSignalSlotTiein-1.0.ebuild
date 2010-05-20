# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-WorkflowSignalSlotTiein/ezc-WorkflowSignalSlotTiein-1.0.ebuild,v 1.2 2010/05/20 04:43:09 pva Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component contains the SignalSlot links for the Workflow component"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-Workflow-1.2
	>=dev-php5/ezc-SignalSlot-1.1"
