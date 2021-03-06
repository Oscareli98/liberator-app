// The MIT License
//
// Copyright (c) 2014 Gwendal Roué
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "GRMustacheAvailabilityMacros_private.h"
#import "GRMustacheASTNode_private.h"

@class GRMustachePartialNode;

/**
 * A GRMustacheInheritablePartialNode is an AST node that represents inheritable
 * partials as `{{<name}}...{{/name}}`.
 */
@interface GRMustacheInheritablePartialNode : NSObject<GRMustacheASTNode> {
@private
    GRMustachePartialNode *_partialNode;
    NSArray *_ASTNodes;
}

/**
 * The overriding AST nodes, built from the inner content of the inheritable
 * partial node:
 *
 *     {{< parent }} overriding AST nodes {{/ }}
 */
@property (nonatomic, retain, readonly) NSArray *ASTNodes GRMUSTACHE_API_INTERNAL;

/**
 * The partial template that is inherited:
 *
 *    {{< inherited_partial_template }}...{{/ }}
 */
@property (nonatomic, retain, readonly) GRMustachePartialNode *partialNode GRMUSTACHE_API_INTERNAL;

/**
 * Builds a GRMustacheInheritablePartialNode.
 *
 * @param partialNode  The inherited partial.
 * @param ASTNodes     The nodes that may override nodes of the inherited
 *                     partial template.
 *
 * @return A GRMustacheInheritablePartialNode
 */
+ (instancetype)inheritablePartialNodeWithPartialNode:(GRMustachePartialNode *)partialNode ASTNodes:(NSArray *)ASTNodes GRMUSTACHE_API_INTERNAL;

@end
