# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-WorkflowEventLogTiein/ezc-WorkflowEventLogTiein-1.1.ebuild,v 1.1 2008/01/13 16:11:59 jokey Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component contains the EventLog listener for the Workflow component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-EventLog-1.1
	>=dev-php5/ezc-Workflow-1.0.1"
