#!/bin/sh
# -----------------------------------------------------------------------------
# build.sh - Unix Build Script for Apache Batik
#
# $Id$
# -----------------------------------------------------------------------------

# ----- Verify and Set Required Environment Variables -------------------------
   
if [ "$ANT_HOME" = "" ] ; then
  ANT_HOME=.
fi

if [ "$JAVA_HOME" = "" ] ; then
  echo You must set JAVA_HOME to point at your Java Development Kit installation
  exit 1
fi

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false;
case "`uname`" in
  CYGWIN*) cygwin=true ;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin ; then
  [ -n "$JAVA_HOME" ] &&
    JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

# ----- Set Up The Runtime Classpath ------------------------------------------

CP=$JAVA_HOME/lib/tools.jar:$ANT_HOME/lib/build/ant_1_4_1.jar:./lib/build/crimson-ant.jar:./lib/build/jaxp.jar

if $cygwin; then
  JAVA_HOME=`cygpath --path --windows "$JAVA_HOME"`
  CP=`cygpath --path --windows "$CP"`
fi

# ----- Execute The Requested Build -------------------------------------------

TARGET=$1;
if [ $# != 0 ] ; then
  shift 1
fi

# $JAVA_HOME/bin/java -version

$JAVA_HOME/bin/java $ANT_OPTS -classpath $CP org.apache.tools.ant.Main -emacs -Dant.home=$ANT_HOME $TARGET -Dargs="$*"
