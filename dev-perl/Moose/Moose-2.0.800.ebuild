# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Moose/Moose-2.0.800.ebuild,v 1.1 2011/06/17 18:41:24 tove Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=2.0008
inherit perl-module

DESCRIPTION="A postmodern object system for Perl 5"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

CONFLICTS="
	!<=dev-perl/Catalyst-5.800.280
	!<=dev-perl/Devel-REPL-1.003008
	!<=dev-perl/Fey-0.360
	!<=dev-perl/Fey-ORM-0.420
	!<=dev-perl/File-ChangeNotify-0.150
	!<=dev-perl/KiokuDB-0.490
	!<=dev-perl/Markdent-0.160
	!<=dev-perl/MooseX-Aliases-0.80
	!<=dev-perl/MooseX-AlwaysCoerce-0.130.0
	!<=dev-perl/MooseX-Attribute-Deflator-2.1.0
	!<=dev-perl/MooseX-Attribute-Dependent-1.1.0
	!<=dev-perl/MooseX-Attribute-Prototype-0.100
	!<=dev-perl/MooseX-AttributeHelpers-0.22
	!<=dev-perl/MooseX-AttributeIndexes-1.0.0
	!<=dev-perl/MooseX-AttributeInflate-0.20
	!<=dev-perl/MooseX-CascadeClearing-0.30.0
	!<=dev-perl/MooseX-ClassAttribute-0.230
	!<=dev-perl/MooseX-Constructor-AllErrors-0.12
	!<=dev-perl/MooseX-FollowPBP-0.20
	!<=dev-perl/MooseX-HasDefaults-0.20
	!<=dev-perl/MooseX-InstanceTracking-0.40
	!<=dev-perl/MooseX-LazyRequire-0.60.0
	!<=dev-perl/MooseX-NonMoose-0.170.0
	!<=dev-perl/MooseX-POE-0.211.0
	!<=dev-perl/MooseX-Params-Validate-0.50
	!<=dev-perl/MooseX-PrivateSetters-0.30.0
	!<=dev-perl/MooseX-Role-Cmd-0.60
	!<=dev-perl/MooseX-Role-Parameterized-0.230.0
	!<=dev-perl/MooseX-Role-WithOverloading-0.070
	!<=dev-perl/MooseX-SemiAffordanceAccessor-0.50
	!<=dev-perl/MooseX-SetOnce-0.100.472
	!<=dev-perl/MooseX-Singleton-0.250
	!<=dev-perl/MooseX-StrictConstructor-0.120
	!<=dev-perl/MooseX-Types-0.190
	!<=dev-perl/MooseX-UndefTolerant-0.110.0
	!<=dev-perl/Pod-Elemental-0.93.280
	!<=dev-perl/Reaction-0.2.3
	!<=dev-perl/namespace-autoclean-0.08
"

RDEPEND="
	${CONFLICTS}
	!dev-perl/Class-MOP
	>=dev-perl/Data-OptList-0.107.0
	dev-perl/Devel-GlobalDestruction
	>=dev-perl/Eval-Closure-0.40.0
	>=dev-perl/List-MoreUtils-0.120
	>=dev-perl/MRO-Compat-0.05
	>=dev-perl/Package-DeprecationManager-0.10
	>=dev-perl/Package-Stash-0.210
	>=dev-perl/Package-Stash-XS-0.180
	>=dev-perl/Params-Util-1
	>=virtual/perl-Scalar-List-Utils-1.19
	>=dev-perl/Sub-Exporter-0.980
	>=dev-perl/Sub-Name-0.05
	>=dev-perl/Try-Tiny-0.20
"
DEPEND="${RDEPEND}
	>=dev-perl/Dist-CheckConflicts-0.20
	>=virtual/perl-ExtUtils-MakeMaker-6.56
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.88
		dev-perl/Test-Requires
		>=dev-perl/Test-Output-0.09
		>=dev-perl/Test-Warn-0.11
		dev-perl/Test-Deep
		dev-perl/Module-Refresh
	)"

SRC_TEST=do
